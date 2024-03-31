import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class RockPile extends SpriteComponent with HasVisibility {
  RockPile() : super(size: Vector2(130, 39), sprite: SpriteManager.getSprite('masonry/rock-pile')) {
    anchor = Anchor.bottomLeft;
    scale = Vector2.all(0.5);
  }
}
