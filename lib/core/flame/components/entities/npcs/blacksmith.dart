import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/mixins/has_value_timer_action.dart';
import 'package:defend_your_flame/core/flame/mixins/has_world_state_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Blacksmith extends SpriteAnimationComponent
    with HasWorldReference<MainWorld>, HasWorldStateManager, HasValueTimerAction {
  static const int percentageOfWallHealthToRepair = 20;

  Blacksmith()
      : super(
          size: Vector2.all(64),
        ) {
    scale = Vector2.all(1.4);
  }

  @override
  Future<void> onLoad() async {
    animation = SpriteManager.getAnimation('npcs/blacksmith/work', frames: 10, stepTime: 0.11);
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

  void performEffect(MainWorld world) {}

  @override
  void emitValue(int valueToGive) {
    world.playerBase.wall.repairWallFor(valueToGive);
  }
}
