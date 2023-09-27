import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

enum SkeletonState { walking, dragged, falling, dying }

class Skeleton extends SpriteAnimationGroupComponent<SkeletonState> with DragCallbacks, HasGameReference<MainGame> {
  // It's a bit small already so 1.2 scale by default.
  static const _defaultEnlargement = 1.2;
  static const _walkingFrames = 13;
  static const _dragFrames = 4;
  static const _dyingFrames = 15;

  static const _walkingSpeedForward = 25;

  late final double _pickupHeight;

  bool _beingDragged = false;
  Vector2 _fallVelocity = Vector2.zero();

  Skeleton({double scaleModifier = 1}) {
    size = Vector2(22, 33);
    scale = Vector2.all(scaleModifier * _defaultEnlargement);
  }

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite =
        SpriteManager.getAnimation('mobs/skeleton/walk', stepTime: 0.09 / scale.x, frames: _walkingFrames, loop: true);

    final dragSprite =
        SpriteManager.getAnimation('mobs/skeleton/drag', stepTime: 0.2 / scale.x, frames: _dragFrames, loop: true);

    final dyingSprite =
        SpriteManager.getAnimation('mobs/skeleton/dying', stepTime: 0.07 / scale.x, frames: _dyingFrames, loop: false);

    animations = {
      SkeletonState.walking: walkingSprite,
      SkeletonState.dragged: dragSprite,
      SkeletonState.falling: dragSprite,
      SkeletonState.dying: dyingSprite,
    };
    current = SkeletonState.walking;
  }

  @override
  void update(double dt) {
    if (current == SkeletonState.walking && !_beingDragged) {
      // Walk forward
      position.x = TimestepHelper.add(position.x, _walkingSpeedForward * scale.x, dt);
    }

    if (current == SkeletonState.falling) {
      _fallVelocity = PhysicsHelper.applyGravityFrictionAndClamp(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          // Random 'death velocity'
          current = SkeletonState.dying;
        } else {
          current = SkeletonState.walking;
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
    position += event.delta / game.cameraZoom;
    _fallVelocity = event.delta * game.cameraZoom * 50;
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
    current = SkeletonState.dragged;
  }

  void stopDragging() {
    if (!_beingDragged) {
      return;
    }

    _beingDragged = false;
    if (position.y < _pickupHeight - 10) {
      current = SkeletonState.falling;
    }
  }
}
