import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';

class ItemDescriptionTitle extends DefaultText {
  ItemDescriptionTitle() : super(textRenderer: TextManager.smallSubHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.description;
    super.onMount();
  }
}
