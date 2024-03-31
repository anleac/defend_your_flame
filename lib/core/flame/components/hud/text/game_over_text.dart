import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_text.dart';

class GameOverText extends DefaultText {
  @override
  void onMount() {
    text = game.appStrings.gameOver;
    super.onMount();
  }
}
