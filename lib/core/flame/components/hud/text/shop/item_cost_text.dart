import 'package:defend_your_flame/core/flame/components/hud/base_components/default_labeled_text.dart';

class ItemCostText extends DefaultLabeledText {
  @override
  void onMount() {
    setLabel(game.appStrings.itemCostLabel);
    super.onMount();
  }
}
