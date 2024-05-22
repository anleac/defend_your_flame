import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:flame/components.dart';

class SaveAndQuitButton extends DefaultButton with ParentIsA<NextRoundMenuHud> {
  SaveAndQuitButton() : super();

  @override
  void onMount() {
    text = game.appStrings.saveAndQuit;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.saveAndQuit();
    super.onPressed();
  }
}
