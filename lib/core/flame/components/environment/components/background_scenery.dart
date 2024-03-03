import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class BackgroundScenery extends SpriteComponent {
  BackgroundScenery() : super(size: Vector2(1440, 746), sprite: SpriteManager.getSprite('background')) {
    scale = Vector2.all(Constants.desiredWidth / 1440);
  }
}
