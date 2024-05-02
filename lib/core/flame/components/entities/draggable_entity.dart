import 'package:defend_your_flame/constants/damage_constants.dart';
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

class DraggableEntity extends Entity with DragCallbacks {
  static const double dragTimeoutInSeconds = 3.5;
  static const double _dragEps = 1;

  static final PaintDecorator _dragTintDecorator = PaintDecorator.tint(const Color.fromARGB(80, 255, 45, 45));

  Vector2 _lastPosition = Vector2.zero();
  Vector2 _velocity = Vector2.zero();
  bool _beingDragged = false;

  Vector2 _dragVelocity = Vector2.zero();

  double _stuckTimerInMilliseconds = 0;
  double _totalDragDistance = 0;

  bool get _contactingGround => startPosition.y - position.y < _dragEps;
  Vector2 get currentVelocity => _beingDragged ? _dragVelocity : _velocity;

  DraggableEntity({required super.entityConfig, super.scaleModifier});

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
    _lastPosition = position.clone();
  }

  void stopDraggingAndBounce() {
    _velocity = _velocity * -0.1;
    stopDragging();
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

    if (_contactingGround && beenDraggedFarEnough) {
      if (DamageHelper.hasDragVelocityImpact(velocity: _dragVelocity, considerHorizontal: false)) {
        dragDamage();
      } else {
        stopDragging();
      }
    }

    var dragChange = position - _lastPosition;
    var dragVelocity = dragChange / dt;
    _updateDragVelocity(dragVelocity);
  }

  bool get beenDraggedFarEnough => _totalDragDistance > 150;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _attemptToBeginDragging();
  }

  // A limitation within Flame draggable callback is that it won't register a start of drag on click, but instead, on drag.
  // This is a workaround to make sure that the drag starts on click.
  @override
  void onTapDown(TapDownEvent event) {
    _attemptToBeginDragging();
  }

  _attemptToBeginDragging() {
    if (!isAlive || _beingDragged) {
      return;
    }

    beginDragging();
  }

  void _updateDragVelocity(Vector2 newVelocity) {
    double influence = newVelocity == Vector2.zero() ? 0.15 : 0.22;
    _dragVelocity.x = influence * newVelocity.x + (1 - influence) * _dragVelocity.x;
    _dragVelocity.y = influence * newVelocity.y + (1 - influence) * _dragVelocity.y;

    _velocity = _dragVelocity / 1.7;
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

    _totalDragDistance += dragDistance.length;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    stopDragging();
  }

  @override
  void onTapUp(TapUpEvent event) {
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

    if (_contactingGround) {
      current = EntityState.walking;
    } else {
      current = EntityState.falling;
    }
  }

  @override
  void wallCollisionCalculation(double dt) {
    if (_beingDragged) {
      if (DamageHelper.hasDragVelocityImpact(velocity: _velocity, considerHorizontal: true)) {
        world.playerBase.takeDamage(DamageConstants.wallImpactDamage.toInt(), position: wallIntersectionPoints.first);
        dragDamage();
      } else {
        stopDragging();
      }
    }

    if (current == EntityState.falling && _contactingGround) {
      current = EntityState.walking;
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

      if (_contactingGround) {
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
