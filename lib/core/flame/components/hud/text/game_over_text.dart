import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class GameOverText extends TextComponent with HasGameReference<MainGame> {
  GameOverText() : super(text: '', anchor: Anchor.center, textRenderer: TextManager.smallHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.gameOver;
    super.onMount();
  }
}
