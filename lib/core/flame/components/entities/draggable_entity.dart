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

class DraggableEntity extends Entity with DragCallbacks, GestureHitboxes {
  static const double dragTimeoutInSeconds = 3.5;

  late final double _pickupHeight;

  Vector2 _fallVelocity = Vector2.zero();
  bool _beingDragged = false;

  Vector2 _dragVelocity = Vector2.zero();

  double _stuckTimerInMilliseconds = 0;
  int _timeSinceLastDragEventInMicroseconds = 0;
  double _totalDragDistance = 0;

  DraggableEntity({required super.entityConfig, super.scaleModifier});

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point);
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
    _checkDragStuckLogic(dt);

    super.update(dt);
  }

  void _checkDragStuckLogic(double dt) {
    if (_beingDragged) {
      _stuckTimerInMilliseconds += dt;
      if (_stuckTimerInMilliseconds > dragTimeoutInSeconds) {
        stopDragging();
      }
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

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (!isAlive) {
      return;
    }

    beginDragging();
  }

  void updateDragVelocity(Vector2 newVelocity) {
    const double influence = 0.2;
    _dragVelocity.x = influence * newVelocity.x + (1 - influence) * _dragVelocity.x;
    _dragVelocity.y = influence * newVelocity.y + (1 - influence) * _dragVelocity.y;

    _fallVelocity = _dragVelocity / 1.6;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    if (!_beingDragged) {
      return;
    }

    var timeSinceLastDragEvent = event.timestamp.inMicroseconds - _timeSinceLastDragEventInMicroseconds;
    _timeSinceLastDragEventInMicroseconds = event.timestamp.inMicroseconds;
    _stuckTimerInMilliseconds = 0;

    var dragDistance = (event.canvasDelta / game.windowScale) * entityConfig.dragResistance;

    // Since we are dealing in time delta in microseconds, we want to divide by 1,000,000 to get seconds.
    const divisionFactor = 1000000;

    var newVelocity = dragDistance / (max(timeSinceLastDragEvent, 1) / divisionFactor);
    updateDragVelocity(newVelocity);

    position += dragDistance;

    position.y = position.y.clamp(BoundingConstants.minYCoordinate, _pickupHeight + 10);
    position.x = position.x
        .clamp(BoundingConstants.minXCoordinateOffScreen, world.worldWidth + BoundingConstants.maxXCoordinateOffScreen);

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
    _timeSinceLastDragEventInMicroseconds = 0;
    _stuckTimerInMilliseconds = 0;
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
    _dragVelocity = PhysicsHelper.applyFriction(_dragVelocity, dt);

    // Helps to reset when drag is idle.
    if (current == EntityState.dragged) {
      updateDragVelocity(Vector2.zero());
    }

    PhysicsHelper.clampVelocity(_fallVelocity);
    PhysicsHelper.clampVelocity(_dragVelocity);

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
