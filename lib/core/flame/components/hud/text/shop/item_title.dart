import 'package:defend_your_flame/core/flame/components/hud/base_components/labeled_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';

class ItemTitle extends LabeledText {
  ItemTitle()
      : super(labelRenderer: TextManager.smallSubHeaderBoldRenderer, textRenderer: TextManager.basicHudRenderer);

  @override
  void onMount() {
    setLabel(game.appStrings.itemTitleLabel);
    super.onMount();
  }
}
