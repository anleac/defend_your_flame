import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/helpers/hud_theming_helper.dart';
import 'package:flame/components.dart';

class ContinueGameButton extends DefaultButton with HasAncestor<GameSelectionHud> {
  ContinueGameButton() : super();

  @override
  void onMount() {
    text = game.appStrings.continueGame;
    toggleClickable(game.gameData.hasAutoSave);

    decorator.removeLast();
    if (!game.gameData.hasAutoSave) {
      decorator.addLast(HudThemingHelper.disabledDecorator);
    }

    super.onMount();
  }

  @override
  void onPressed() {
    if (game.gameData.hasAutoSave) {
      var gameData = game.gameData.autoSave;
      ancestor.attemptStartGame(save: gameData);
    }
    super.onPressed();
  }
}
