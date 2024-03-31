import 'dart:math';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class DraggableEntity extends Entity with DragCallbacks {
  late final double _pickupHeight;

  Vector2 _fallVelocity = Vector2.zero();
  bool _beingDragged = false;

  Vector2 _dragVelocity = Vector2.zero();
  int _timeSinceLastDragEvent = 0;
  double _totalDragDistance = 0;

  DraggableEntity({required super.entityConfig, super.scaleModifier});

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return super.pointInside(point);
  }

  @override
  Future<void> onLoad() async {
    assert(entityConfig.dragConfig != null,
        'Drag config must be set for a draggable entity: ${entityConfig.entityResourceName}');

    final dragSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/drag',
        stepTime: entityConfig.dragConfig!.stepTime / scale.x, frames: entityConfig.dragConfig!.frames, loop: true);

    animations = {
      EntityState.dragged: dragSprite,
      EntityState.falling: dragSprite,
    };

    super.onLoad();
  }

  @override
  void update(double dt) {
    _dragCalculation(dt);

    super.update(dt);
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

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (!isAlive) {
      return;
    }

    beginDragging();
  }

  void updateDragVelocity(Vector2 newVelocity) {
    const double influence = 0.1;
    _dragVelocity.x = influence * newVelocity.x + (1 - influence) * _dragVelocity.x;
    _dragVelocity.y = influence * newVelocity.y + (1 - influence) * _dragVelocity.y;

    _fallVelocity = _dragVelocity / 1.5;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    if (!_beingDragged) {
      return;
    }

    var timeSinceLastDragEvent = event.timestamp.inMilliseconds - _timeSinceLastDragEvent;
    _timeSinceLastDragEvent = event.timestamp.inMilliseconds;

    var newVelocity = (event.canvasDelta) / (max(timeSinceLastDragEvent, 1) / 1200.0);
    updateDragVelocity(newVelocity);

    position += event.canvasDelta / game.windowScale;
    position.y = position.y.clamp(BoundingConstants.minYCoordinate, _pickupHeight + 10);

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
    _timeSinceLastDragEvent = 0;
    current = EntityState.dragged;
  }

  void dragDeath() {
    hitGround();
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

  @override
  void fallingCalculation(double dt) {
    // Always do this, even if not falling, to scale drag velocity updates.
    _fallVelocity = PhysicsHelper.applyFriction(_fallVelocity, dt);
    PhysicsHelper.clampVelocity(_fallVelocity);

    if (current == EntityState.falling) {
      _fallVelocity = PhysicsHelper.applyGravity(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          hitGround();
        } else {
          current = EntityState.walking;
        }
      }
    }

    super.fallingCalculation(dt);
  }

  void hitGround() {
    super.takeDamage(DamageConstants.fallDamage);

    if (isAlive) {
      current = EntityState.walking;
    }
  }
}
