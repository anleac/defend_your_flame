import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';

class SaveOverwriteText extends DefaultText {
  SaveOverwriteText() : super(textRenderer: TextManager.smallHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.overwriteConfirmation;
    super.onMount();
  }
}
