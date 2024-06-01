import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flame_type.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/misc/rock_circle.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/mixins/has_value_timer_action.dart';
import 'package:defend_your_flame/core/flame/mixins/has_world_state_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class FirePit extends PositionComponent
    with ParentIsA<PlayerBase>, HasWorldReference<MainWorld>, HasWorldStateManager, HasValueTimerAction {
  static const FlameType defaultFlameType = FlameType.basic;

  double get _scaleFactor => _flameType.scale;
  double get _rockPitScaleFactor => ((_scaleFactor - 1) / 3) + 1;
  Vector2 get _flameScale => Vector2(1.2, 2.5) * (((_scaleFactor - 1) * 1.1) + 1);

  FlameType _flameType = defaultFlameType;

  FlameType get flameType => _flameType;

  late final RockCircle _rockFirePit = RockCircle()
    ..position = Vector2(0, 0)
    ..scale = Vector2.all(_rockPitScaleFactor)
    ..anchor = Anchor.center;

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = Vector2(ParallaxConstants.horizontalDisplacementFactor * _rockFirePit.size.y / 2, 2)
    ..scale = _flameScale
    ..anchor = Anchor.bottomCenter;

  @override
  Future<void> onLoad() async {
    add(_rockFirePit);
    add(_firePitFlame);
    return super.onLoad();
  }

  void updateType(FlameType flameType) {
    if (_flameType == flameType) {
      return;
    }

    _flameType = flameType;
    _rockFirePit.scale = Vector2.all(_rockPitScaleFactor);
    _rockFirePit.takeSnapshot();
    _firePitFlame.scale = _flameScale;
  }

  void reset() {
    updateType(defaultFlameType);
  }

  @override
  void emitValue(int valueToGive) {
    if (isPlaying && valueToGive > 0) {
      world.playerBase.addFlameMana(valueToGive, _firePitFlame.absoluteCenter);
    }
  }

  @override
  void onRoundStart(int currentRound, double spawnDuration, double approximateTotalDuration) {
    double flameToGiveThisRound = (10 + currentRound.toDouble() * _flameType.manaOutput);
    startTimer(
        valueToGive: flameToGiveThisRound, durationOver: approximateTotalDuration, percentageToGiveOnEmission: 10);
  }

  @override
  void onRoundEnd() {
    forceEndTimer();
  }
}
