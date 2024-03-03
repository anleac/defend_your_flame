import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Ground extends SpriteComponent with ParentIsA<MainWorld> {
  Ground() : super(size: Vector2(1118, 223), sprite: SpriteManager.getSprite('grass'));
}
