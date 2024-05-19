import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class FlameIcon extends SpriteComponent {
  FlameIcon() : super(size: Vector2(24, 41), sprite: SpriteManager.getSprite('hud/flame'));
}
