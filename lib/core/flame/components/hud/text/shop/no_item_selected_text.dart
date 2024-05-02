import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';

class NoItemSelectedText extends DefaultText with HasVisibility {
  NoItemSelectedText() : super(textRenderer: TextManager.smallHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.noItemSelected;
    super.onMount();
  }
}
