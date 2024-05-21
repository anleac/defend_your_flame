import 'package:defend_your_flame/core/flame/components/hud/base_components/stateful_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_menu_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/save_load/load_game_hud.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';

class GameSelectionHud extends StatefulHud<GameSelectionHudState> {
  GameSelectionHud() {
    init(GameSelectionHudState.menu, {
      GameSelectionHudState.menu: GameSelectionMenuHud(),
      GameSelectionHudState.loadGame: LoadGameHud(),
    });
  }

  void startGame({int? round, int? gold}) {
    if (round != null && gold != null) {
      world.playerBase.mutateGold(gold);
      world.roundManager.overrideRound(round - 1);

      world.worldStateManager.changeState(MainWorldState.betweenRounds);
    } else {
      world.roundManager.startNextRound();
    }
  }
}
