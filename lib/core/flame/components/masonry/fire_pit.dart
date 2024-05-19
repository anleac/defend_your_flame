import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/misc/rock_circle.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/mixins/has_world_state_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class FirePit extends PositionComponent with ParentIsA<PlayerBase>, HasWorldReference<MainWorld>, HasWorldStateManager {
  final double _scaleFactor = 1;

  double get _rockPitScaleFactor => ((_scaleFactor - 1) / 2) + 1;

  int _flameToGiveThisRound = 0;
  int _totalFlameGiven = 0;
  double _timer = 0;
  double _timerTicker = 0;

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
  void update(double dt) {
    if (isPlaying && _totalFlameGiven < _flameToGiveThisRound) {
      _timer += dt;
      if (_timer >= _timerTicker) {
        _timer = 0;
        var toGiveThisTick = 1;
        _totalFlameGiven += toGiveThisTick;
        world.playerBase.addFlameMana(toGiveThisTick, _firePitFlame.absoluteCenter);
      }
    }

    super.update(dt);
  }

  @override
  void onRoundStart(int currentRound, double approximateSecondsOfRound) {
    _flameToGiveThisRound = 10 + currentRound;
    _timerTicker = _flameToGiveThisRound / approximateSecondsOfRound * 1.5;
    _timer = 0;
    _totalFlameGiven = 0;
  }

  @override
  void onRoundEnd() {
    var remainingFlameToGive = _flameToGiveThisRound - _totalFlameGiven;
    if (remainingFlameToGive == 0) return;

    world.playerBase.addFlameMana(remainingFlameToGive, _firePitFlame.absoluteCenter);
  }
}
