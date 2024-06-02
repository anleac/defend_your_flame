import 'package:defend_your_flame/core/flame/components/entities/npcs/base_npc.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';

class Blacksmith extends BaseNpc {
  static const int percentageOfWallHealthToRepair = 20;

  Blacksmith()
      : super(
          size: Vector2.all(64),
        );

  @override
  Iterable<SpriteAnimation> loadAnimations() {
    return [SpriteManager.getAnimation('npcs/blacksmith/work', frames: 10, stepTime: 0.11)];
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
