import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';

class LoadGameTitleText extends DefaultText {
  LoadGameTitleText() : super(textRenderer: TextManager.headerRenderer);

  @override
  void onMount() {
    text = game.appStrings.loadGame;
    super.onMount();
  }
}
