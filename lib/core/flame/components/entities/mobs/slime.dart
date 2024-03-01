import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

enum SlimeState { walking, dragged, falling, dying }

class Slime extends SpriteAnimationGroupComponent<SlimeState> with DragCallbacks, HasGameReference<MainGame> {
  static const _walkingFrames = 4;
  static const _dragFrames = 4;

  static const _walkingSpeedForward = 40;

  late final double _pickupHeight;

  bool _beingDragged = false;
  Vector2 _fallVelocity = Vector2.zero();

  late final double scaleModifier;

  Slime({this.scaleModifier = 1}) {
    size = Vector2(34, 27);
    scale = Vector2.all(scaleModifier);
  }

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite = SpriteManager.getAnimation('mobs/slime/walk',
        stepTime: 0.12 / scaleModifier, frames: _walkingFrames, loop: true);

    final dragSprite =
        SpriteManager.getAnimation('mobs/slime/drag', stepTime: 0.1 / scaleModifier, frames: _dragFrames, loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/slime/dying',
        stepTime: 0.07 / scaleModifier, frames: _dragFrames, loop: false);

    animations = {
      SlimeState.walking: walkingSprite,
      SlimeState.dragged: dragSprite,
      SlimeState.falling: dragSprite,
      SlimeState.dying: dyingSprite,
    };
    current = SlimeState.walking;
  }

  @override
  void update(double dt) {
    if (current == SlimeState.walking && !_beingDragged) {
      // Walk forward
      position.x = TimestepHelper.add(position.x, _walkingSpeedForward * scale.x, dt);
    }

    if (current == SlimeState.falling) {
      _fallVelocity = PhysicsHelper.applyGravityFrictionAndClamp(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          // Random 'death velocity'
          current = SlimeState.dying;
        } else {
          current = SlimeState.walking;
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
    _fallVelocity = event.canvasDelta * game.cameraZoom * 50;
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
    current = SlimeState.dragged;
  }

  void stopDragging() {
    if (!_beingDragged) {
      return;
    }

    _beingDragged = false;
    if (position.y < _pickupHeight - 10) {
      current = SlimeState.falling;
    }
  }
}
