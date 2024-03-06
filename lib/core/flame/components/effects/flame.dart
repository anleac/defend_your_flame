import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class Flame extends SpriteAnimationComponent {
  Flame()
      : super(
            size: Vector2(32, 24),
            animation: SpriteManager.getAnimation('flames/purple/loops/1', frames: 8, stepTime: 0.08));
}
