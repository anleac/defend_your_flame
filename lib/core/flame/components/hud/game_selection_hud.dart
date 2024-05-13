import 'dart:async';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/fast_track_to_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/start_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/load_game_button.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class GameSelectionHud extends BasicHud {
  late final StartGameButton _startGame = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3);

  late final FastTrackToButton _fastTrackToTen = FastTrackToButton(round: 10, gold: 400)
    ..position = _startGame.position + ThemingConstants.menuButtonGap;

  late final FastTrackToButton _fastTrackToFifteen = FastTrackToButton(round: 15, gold: 800)
    ..position = _fastTrackToTen.position + ThemingConstants.menuButtonGap;

  late final LoadGameButton _loadGame = LoadGameButton()
    ..position = _fastTrackToFifteen.position + ThemingConstants.menuButtonGap;

  late final GoBackButton _goBackButton = GoBackButton(backFunction: () {
    world.worldStateManager.changeState(MainWorldState.mainMenu);
  })
    ..position = _loadGame.position + ThemingConstants.menuButtonGap;

  @override
  FutureOr<void> onLoad() {
    add(_startGame);
    add(_fastTrackToTen);
    add(_fastTrackToFifteen);
    add(_loadGame);
    add(_goBackButton);

    return super.onLoad();
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
