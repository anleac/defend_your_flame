import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class PurpleFlame extends SpriteAnimationComponent with HasVisibility {
  PurpleFlame()
      : super(
            size: Vector2(32, 24),
            animation: SpriteManager.getAnimation('flames/purple/loops/1', frames: 8, stepTime: 0.10)) {}
}
