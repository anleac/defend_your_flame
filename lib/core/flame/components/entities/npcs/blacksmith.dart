import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Blacksmith extends SpriteAnimationComponent with HasWorldReference<MainWorld> {
  static const int percentageOfWallHealthToRepair = 20;

  Blacksmith()
      : super(
          size: Vector2.all(64),
        ) {
    scale = Vector2.all(1.4);
  }

  int get repairPercentage => percentageOfWallHealthToRepair;

  @override
  Future<void> onLoad() async {
    animation = SpriteManager.getAnimation('npcs/blacksmith/work', frames: 10, stepTime: 0.11);
  }

  void repairWall() {}
}
