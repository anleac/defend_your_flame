import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_hud_state.dart';
import 'package:flame/components.dart';

class LoadGameButton extends DefaultButton with HasAncestor<GameSelectionHud> {
  LoadGameButton() : super(comingSoon: true);

  @override
  void onMount() {
    text = game.appStrings.loadGame;
    super.onMount();
  }

  @override
  void onPressed() {
    ancestor.changeState(GameSelectionHudState.loadGame);
    super.onPressed();
  }
}
