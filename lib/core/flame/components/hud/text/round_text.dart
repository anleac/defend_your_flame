import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class RoundText extends TextComponent with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  int _currentRound = 0;

  String get _roundText => game.appStrings.roundText(_currentRound);

  RoundText() : super(textRenderer: TextManager.smallHeaderRenderer);

  @override
  void update(double dt) {
    if (world.roundManager.currentRound != _currentRound) {
      _currentRound = world.roundManager.currentRound;
      text = _roundText;
    }

    super.update(dt);
  }
}
