import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:flame/components.dart';

class SaveGameButton extends DefaultButton with ParentIsA<NextRoundMenuHud> {
  SaveGameButton() : super(comingSoon: true);

  @override
  void onMount() {
    text = game.appStrings.saveGame;
    super.onMount();
  }

  @override
  void onPressed() {
    // TODO - save a game!
  }
}
