import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class BlueFlame extends SpriteAnimationComponent with HasVisibility {
  BlueFlame()
      : super(
            size: Vector2(24, 20),
            animation: SpriteManager.getAnimation('flames/blue/loops/2', frames: 8, stepTime: 0.11));
}
