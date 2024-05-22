import 'package:defend_your_flame/core/flame/components/hud/base_components/stateful_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_menu_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/save_overwrite_hud.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';

class GameSelectionHud extends StatefulHud<GameSelectionHudState> {
  int? _gold;
  int? _round;

  GameSelectionHud() {
    init(GameSelectionHudState.menu, {
      GameSelectionHudState.menu: GameSelectionMenuHud(),
      GameSelectionHudState.saveOverwriteConfirmation: SaveOverwriteHud(),
    });
  }

  void attemptStartGame({GameSave? save, int? gold, int? round}) {
    if (save != null) {
      world.activeGameManager.loadGame(save);
      world.worldStateManager.changeState(MainWorldState.betweenRounds);
    } else {
      _gold = gold;
      _round = round;

      if (world.activeGameManager.hasAutoSave) {
        changeState(GameSelectionHudState.saveOverwriteConfirmation);
      } else {
        forceStartNewGame();
      }
    }
  }

  void forceStartNewGame() {
    restoreDefaultHudState();
    world.activeGameManager.resetGame();
    world.activeGameManager.clearAutoSave();
    if (_gold != null && _round != null) {
      // Used in the fast track buttons
      world.playerBase.mutateGold(_gold!);
      world.roundManager.overrideRound(_round! - 1);
      world.worldStateManager.changeState(MainWorldState.betweenRounds);
    } else {
      world.roundManager.startNextRound();
    }
  }
}
