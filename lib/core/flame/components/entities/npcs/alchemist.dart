import 'package:defend_your_flame/core/flame/components/entities/npcs/base_npc.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class Alchemist extends BaseNpc {
  static const int percentageOfWallHealthToRepair = 2;

  Alchemist()
      : super(
          size: Vector2.all(64),
        ) {
    flipHorizontally();
  }

  @override
  Iterable<SpriteAnimation> loadAnimations() {
    return [
      SpriteManager.getAnimation('npcs/alchemist/work', frames: 14, stepTime: 0.14),
      SpriteManager.getAnimation('npcs/alchemist/work2', frames: 10, stepTime: 0.14)
    ];
  }

  @override
  void onRoundStart(int currentRound, double spawnDuration, double approximateTotalDuration) {
    startTimer(valueToGive: percentageOfWallHealthToRepair.toDouble(), durationOver: approximateTotalDuration);
    super.onRoundStart(currentRound, spawnDuration, approximateTotalDuration);
  }

  @override
  void onRoundEnd() {
    forceEndTimer();
    super.onRoundEnd();
  }

  @override
  void emitValue(int valueToGive) {
    world.playerBase.wall.repairWallFor(valueToGive);
  }
}
