import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class GoldPile extends SpriteComponent {
  GoldPile() : super(size: Vector2(100, 71), sprite: SpriteManager.getSprite('hud/gold'));
}
