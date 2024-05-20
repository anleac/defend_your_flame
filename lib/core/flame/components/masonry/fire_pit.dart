import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/misc/rock_circle.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/mixins/has_value_timer_action.dart';
import 'package:defend_your_flame/core/flame/mixins/has_world_state_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class FirePit extends PositionComponent
    with ParentIsA<PlayerBase>, HasWorldReference<MainWorld>, HasWorldStateManager, HasValueTimerAction {
  final double _scaleFactor = 1;

  double get _rockPitScaleFactor => ((_scaleFactor - 1) / 2) + 1;

  late final RockCircle _rockFirePit = RockCircle()
    ..position = Vector2(0, 0)
    ..scale = Vector2.all(1) * _rockPitScaleFactor
    ..anchor = Anchor.center;

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = Vector2(ParallaxConstants.horizontalDisplacementFactor * _rockFirePit.size.y / 2, 2)
    ..scale = Vector2(1.2, 2.5) * _scaleFactor
    ..anchor = Anchor.bottomCenter;

  @override
  Future<void> onLoad() async {
    add(_rockFirePit);
    add(_firePitFlame);
    return super.onLoad();
  }

  @override
  void emitValue(int valueToGive) {
    if (isPlaying && valueToGive > 0) {
      world.playerBase.addFlameMana(valueToGive, _firePitFlame.absoluteCenter);
    }
  }

  @override
  void onRoundStart(int currentRound, double spawnDuration, double approximateTotalDuration) {
    double flameToGiveThisRound = 10 + currentRound.toDouble();
    startTimer(
        valueToGive: flameToGiveThisRound, durationOver: approximateTotalDuration, percentageToGiveOnEmission: 10);
  }

  @override
  void onRoundEnd() {
    forceEndTimer();
  }
}
