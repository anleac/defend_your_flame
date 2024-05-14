import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class Ground extends SpriteComponent {
  Ground() : super(size: Vector2(1118, 223), sprite: SpriteManager.getSprite('environment/grass'));
}
