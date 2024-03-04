import 'dart:math';

import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity_config.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/debug/timestep_faker.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class WalkingEntity extends SpriteAnimationGroupComponent<EntityState>
    with DragCallbacks, ParentIsA<EntityManager>, HasGameReference<MainGame>, HasVisibility {
  final WalkingEntityConfig entityConfig;

  late final double _pickupHeight;

  bool get isAlive => current != EntityState.dying;

  bool _beingDragged = false;
  Vector2 _fallVelocity = Vector2.zero();

  Vector2 _dragVelocity = Vector2.zero();
  double _timeSinceLastDragEvent = 0;
  double _totalDragDistance = 0;

  final double _alpha = 0.2;

  void updateDragVelocity(Vector2 newVelocity) {
    _dragVelocity.x = _alpha * newVelocity.x + (1 - _alpha) * _dragVelocity.x;
    _dragVelocity.y = _alpha * newVelocity.y + (1 - _alpha) * _dragVelocity.y;
  }

  late Vector2 _attackingSize;

  WalkingEntity({required this.entityConfig, double scaleModifier = 1}) {
    size = entityConfig.defaultSize;
    _attackingSize = entityConfig.attackingSize ?? size;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);
  }

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/walk',
        stepTime: entityConfig.walkingConfig.stepTime / scale.x, frames: entityConfig.walkingConfig.frames, loop: true);

    final attackingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/attack',
        stepTime: entityConfig.attackingConfig.stepTime / scale.x,
        frames: entityConfig.attackingConfig.frames,
        loop: true);

    final dragSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/drag',
        stepTime: entityConfig.dragConfig.stepTime / scale.x, frames: entityConfig.dragConfig.frames, loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/dying',
        stepTime: entityConfig.dyingConfig.stepTime / scale.x, frames: entityConfig.dyingConfig.frames, loop: false);

    animations = {
      EntityState.walking: walkingSprite,
      EntityState.attacking: attackingSprite,
      EntityState.dragged: dragSprite,
      EntityState.falling: dragSprite,
      EntityState.dying: dyingSprite,
    };

    current = EntityState.walking;
  }

  @override
  void update(double dt) {
    var fakeTimestep = game.findByKeyName<TimestepFaker>(TimestepFaker.componentKey);

    if (fakeTimestep != null) {
      fakeTimestep.updateWithFakeTimestep(dt, _updateMovement);
    } else {
      _updateMovement(dt);
    }

    super.update(dt);
  }

  void _updateMovement(double dt) {
    _logicCalculation(dt);
    _dragCalculation(dt);
    _fallingCalculation(dt);
  }

  void _logicCalculation(double dt) {
    // Special case where the attacking animation is bigger than the default size.
    size = current == EntityState.attacking ? _attackingSize : entityConfig.defaultSize;

    if (current == EntityState.walking &&
        !_beingDragged &&
        position.x + (_attackingSize.x / 4) < parent.positionXBoundary) {
      position.x = TimestepHelper.add(position.x, entityConfig.walkingForwardSpeed * scale.x, dt);
    } else if (position.x >= parent.positionXBoundary + 50 && current == EntityState.walking) {
      // TODO this is an MVP way to remove a edge case from early development, definitely re-visit this and remove it.
      current = EntityState.dying;
    } else if (position.x <= parent.positionXBoundary + 15 && current == EntityState.walking) {
      current = EntityState.attacking;
    }
  }

  void _dragCalculation(double dt) {
    if (_beingDragged) {
      // Want to ensure they've been dragged at least a bit to avoid abuse.
      if (position.y >= _pickupHeight - 10 && _totalDragDistance > 150) {
        if (_dragVelocity.y > PhysicsConstants.maxVelocity.y * 0.9) {
          // Slammed into the ground.
          dragDeath();
        }
      }
    }
  }

  void _fallingCalculation(double dt) {
    if (current == EntityState.falling) {
      _fallVelocity = PhysicsHelper.applyGravityFrictionAndClamp(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          // Random 'death velocity'
          current = EntityState.dying;
        } else {
          current = EntityState.walking;
        }
      }
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (!isAlive) {
      return;
    }

    beginDragging();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!_beingDragged) {
      return;
    }

    var timeNow = DateTime.now().millisecondsSinceEpoch.toDouble();
    var timeSinceLastDragEvent = timeNow - _timeSinceLastDragEvent;
    _timeSinceLastDragEvent = timeNow;

    var newVelocity = (event.canvasDelta) / (max(timeSinceLastDragEvent, 1) / 1000.0);
    updateDragVelocity(newVelocity);

    position += event.canvasDelta / game.windowScale;
    position.y = position.y.clamp(-200, _pickupHeight + 10);
    _fallVelocity = event.canvasDelta / game.windowScale * 30;
    _totalDragDistance += event.canvasDelta.length;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    stopDragging();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    stopDragging();
  }

  void beginDragging() {
    if (_beingDragged) {
      return;
    }

    _beingDragged = true;
    _totalDragDistance = 0;
    _dragVelocity = Vector2.zero();
    _timeSinceLastDragEvent = DateTime.now().millisecondsSinceEpoch.toDouble();
    current = EntityState.dragged;
  }

  void dragDeath() {
    current = EntityState.dying;
    stopDragging();
  }

  void stopDragging() {
    if (!_beingDragged) {
      return;
    }

    _beingDragged = false;

    if (current == EntityState.dying) {
      return;
    }

    if (position.y < _pickupHeight - 10) {
      current = EntityState.falling;
    } else {
      current = EntityState.walking;
    }
  }
}
