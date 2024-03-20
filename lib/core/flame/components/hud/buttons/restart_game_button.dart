import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_over_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class RestartGameButton extends DefaultButton with ParentIsA<GameOverHud>, HasGameReference<MainGame> {
  RestartGameButton() : super();

  @override
  void onMount() {
    text = game.appStrings.restartGame;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.restartGame();
  }
}
