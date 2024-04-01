import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/main_menu_hud.dart';
import 'package:flame/components.dart';

class StartGameButton extends DefaultButton with ParentIsA<MainMenuHud> {
  StartGameButton() : super();

  @override
  void onMount() {
    text = game.appStrings.startGame;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.startRound();
  }
}
