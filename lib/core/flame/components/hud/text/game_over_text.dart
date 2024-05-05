import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';

class GameOverText extends DefaultText {
  GameOverText() : super(textRenderer: TextManager.largeHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.gameOver;
    super.onMount();
  }
}
