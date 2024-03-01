import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity_config.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class WalkingEntity extends SpriteAnimationGroupComponent<EntityState> with DragCallbacks, HasGameReference<MainGame> {
  final WalkingEntityConfig entityConfig;

  late final double _pickupHeight;

  bool _beingDragged = false;
  Vector2 _fallVelocity = Vector2.zero();

  WalkingEntity({required this.entityConfig}) {
    size = Vector2(22, 33);
    scale = Vector2.all(entityConfig.scale);
  }

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/walk',
        stepTime: 0.09 / scale.x, frames: entityConfig.walkingFrames, loop: true);

    final dragSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/drag',
        stepTime: 0.2 / scale.x, frames: entityConfig.dragFrames, loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/dying',
        stepTime: 0.07 / scale.x, frames: entityConfig.dyingFrames, loop: false);

    animations = {
      EntityState.walking: walkingSprite,
      EntityState.dragged: dragSprite,
      EntityState.falling: dragSprite,
      EntityState.dying: dyingSprite,
    };

    current = EntityState.walking;
  }

  @override
  void update(double dt) {
    if (current == EntityState.walking && !_beingDragged) {
      // Walk forward
      position.x = TimestepHelper.add(position.x, entityConfig.walkingForwardSpeed * scale.x, dt);
    }

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

    super.update(dt);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    beginDragging();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position += event.canvasDelta / game.cameraZoom;
    _fallVelocity = event.canvasDelta * game.cameraZoom * 70;
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
    current = EntityState.dragged;
  }

  void stopDragging() {
    if (!_beingDragged) {
      return;
    }

    _beingDragged = false;
    if (position.y < _pickupHeight - 10) {
      current = EntityState.falling;
    }
  }
}
