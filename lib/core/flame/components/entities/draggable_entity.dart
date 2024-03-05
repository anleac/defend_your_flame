import 'dart:math';

import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class DraggableEntity extends Entity with DragCallbacks {
  late final double _pickupHeight;
  bool _beingDragged = false;

  Vector2 _dragVelocity = Vector2.zero();
  double _timeSinceLastDragEvent = 0;
  double _totalDragDistance = 0;

  DraggableEntity({required super.entityConfig, super.scaleModifier});

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final dragSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/drag',
        stepTime: entityConfig.dragConfig.stepTime / scale.x, frames: entityConfig.dragConfig.frames, loop: true);

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
    const double _impact = 0.2;
    _dragVelocity.x = _impact * newVelocity.x + (1 - _impact) * _dragVelocity.x;
    _dragVelocity.y = _impact * newVelocity.y + (1 - _impact) * _dragVelocity.y;
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
    super.overrideFallVelocity(_dragVelocity);

    position += event.canvasDelta / game.windowScale;
    position.y = position.y.clamp(-200, _pickupHeight + 10);

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
