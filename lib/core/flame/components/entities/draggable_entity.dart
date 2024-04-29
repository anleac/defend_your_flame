import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/helpers/damage_helper.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class DraggableEntity extends Entity with DragCallbacks, GestureHitboxes {
  static const double dragTimeoutInSeconds = 3.5;
  static const double _dragEps = 1;

  static final PaintDecorator _dragTintDecorator = PaintDecorator.tint(const Color.fromARGB(80, 255, 45, 45));

  late final double _pickupHeight;

  Vector2 _lastDraggedPosition = Vector2.zero();
  Vector2 _velocity = Vector2.zero();
  bool _beingDragged = false;

  Vector2 _dragVelocity = Vector2.zero();

  double _stuckTimerInMilliseconds = 0;
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
    if (!_beingDragged) {
      return;
    }

    if (position.y >= _pickupHeight - _dragEps && beenDraggedFarEnough) {
      if (DamageHelper.hasDragVelocityImpact(velocity: _velocity, considerHorizontal: false)) {
        dragDamage();
      } else {
        stopDragging();
      }
    }

    var dragDistance = position - _lastDraggedPosition;
    _updateDragVelocity(dragDistance * (1 / dt));

    _lastDraggedPosition = position.clone();
  }

  bool get beenDraggedFarEnough => _totalDragDistance > 150;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (!isAlive) {
      return;
    }

    beginDragging();
  }

  void _updateDragVelocity(Vector2 newVelocity) {
    const double influence = 0.7;
    _dragVelocity.x = influence * newVelocity.x + (1 - influence) * _dragVelocity.x;
    _dragVelocity.y = influence * newVelocity.y + (1 - influence) * _dragVelocity.y;

    _velocity = _dragVelocity / 2;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _stuckTimerInMilliseconds = 0;

    if (!_beingDragged || isCollidingWithWall) {
      return;
    }

    var dragDistance = (event.canvasDelta / game.windowScale) * entityConfig.dragResistance;
    position += dragDistance;

    position.y = position.y.clamp(BoundingConstants.minYCoordinate, _pickupHeight + MiscConstants.eps);
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
    _clearVelocities();
    _stuckTimerInMilliseconds = 0;
    current = EntityState.dragged;

    decorator.addLast(_dragTintDecorator);
  }

  void dragDamage() {
    hitGround(forceDamage: true);
    stopDragging();
  }

  void stopDragging() {
    if (!_beingDragged) {
      return;
    }

    decorator.removeLast();

    _beingDragged = false;

    if (current == EntityState.dying) {
      return;
    }

    if (position.y < _pickupHeight - _dragEps) {
      current = EntityState.falling;
    } else {
      current = EntityState.walking;
    }
  }

  @override
  void wallCollisionCalculation(double dt) {
    if (_beingDragged) {
      if (DamageHelper.hasDragVelocityImpact(velocity: _velocity, considerHorizontal: true)) {
        world.playerManager.playerBase
            .takeDamage(DamageConstants.wallImpactDamage.toInt(), position: wallIntersectionPoints.first);
        dragDamage();
      } else {
        stopDragging();
      }
    }

    if (current == EntityState.falling) {
      if (position.y >= _pickupHeight) {
        current = EntityState.walking;
      }
    }

    super.wallCollisionCalculation(dt);
  }

  @override
  void fallingCalculation(double dt) {
    // Always do this, even if not falling, to scale drag velocity updates.
    _velocity = PhysicsHelper.applyFriction(_velocity, dt);
    _dragVelocity = PhysicsHelper.applyFriction(_dragVelocity, dt);

    PhysicsHelper.clampVelocity(_velocity);
    PhysicsHelper.clampVelocity(_dragVelocity);

    if (current == EntityState.falling && !isCollidingWithWall) {
      _velocity = PhysicsHelper.applyGravity(_velocity, dt);
      position = TimestepHelper.addVector2(position, _velocity, dt);

      if (position.y >= _pickupHeight) {
        hitGround();
      }
    }

    super.fallingCalculation(dt);
  }

  void hitGround({bool forceDamage = false}) {
    if (forceDamage || DamageHelper.hasFallVelocityImpact(velocity: _velocity)) {
      super.takeDamage(DamageConstants.fallDamage);
    }

    _clearVelocities();

    if (isAlive) {
      current = EntityState.walking;
    }
  }

  _clearVelocities() {
    _velocity = Vector2.zero();
    _dragVelocity = Vector2.zero();
  }
}
