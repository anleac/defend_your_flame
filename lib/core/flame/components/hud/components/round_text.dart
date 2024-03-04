import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class RoundText extends TextComponent with ParentIsA<LevelHud>, HasGameReference<MainGame>, HasVisibility {
  int _currentRound = 1;

  String get _roundText => game.appStrings.roundText(_currentRound);

  @override
  void update(double dt) {
    if (parent.currentRound != _currentRound) {
      _currentRound = parent.currentRound;
      text = _roundText;
    }

    isVisible = !parent.roundOver;

    super.update(dt);
  }
}
