import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class RockHeart extends SpriteComponent {
  RockHeart() : super(size: Vector2(100, 90), sprite: SpriteManager.getSprite('hud/heart'));
}
