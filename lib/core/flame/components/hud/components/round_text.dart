import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class RoundText extends TextComponent with ParentIsA<MainWorld>, HasGameRef<MainGame> {
  int _currentRound = 1;

  String get _roundText => game.appStrings.roundText(_currentRound);

  @override
  void update(double dt) {
    if (parent.currentRound != _currentRound) {
      _currentRound = parent.currentRound;
      text = _roundText;
    }

    super.update(dt);
  }
}
