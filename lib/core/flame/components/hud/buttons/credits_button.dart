import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/main_menu_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class CreditsButton extends DefaultButton with ParentIsA<MainMenuHud>, HasGameReference<MainGame> {
  CreditsButton() : super(comingSoon: true);

  @override
  void onMount() {
    text = game.appStrings.credits;
    super.onMount();
  }

  @override
  void onPressed() {
    // TODO - load a game!
  }
}
