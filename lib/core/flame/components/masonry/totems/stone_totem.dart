import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class StoneTotem extends SpriteComponent {
  StoneTotem() : super(size: Vector2(50, 100), sprite: SpriteManager.getSprite('masonry/stone-totem'));
}
