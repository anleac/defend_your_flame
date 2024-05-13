import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/main_menu_hud.dart';
import 'package:flame/components.dart';

class SelectGameButton extends DefaultButton with ParentIsA<MainMenuHud> {
  SelectGameButton() : super();

  @override
  void onMount() {
    text = game.appStrings.selectGame;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.goToGameSelection();
  }
}
