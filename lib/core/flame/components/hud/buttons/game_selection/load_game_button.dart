import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:flame/components.dart';

class LoadGameButton extends DefaultButton with ParentIsA<GameSelectionHud> {
  LoadGameButton() : super(comingSoon: true);

  @override
  void onMount() {
    text = game.appStrings.loadGame;
    super.onMount();
  }

  @override
  void onPressed() {
    // TODO - load a game!
  }
}
