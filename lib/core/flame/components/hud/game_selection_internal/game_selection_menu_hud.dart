import 'dart:async';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/continue_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/fast_track_to_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/game_selection/start_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class GameSelectionMenuHud extends BasicHud {
  late final StartGameButton _startGame = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4);

  late final ContinueGameButton _continueGame = ContinueGameButton();

  late final FastTrackToButton _fastTrackToTen = FastTrackToButton(round: 10, gold: 480);

  late final FastTrackToButton _fastTrackToFifteen = FastTrackToButton(round: 15, gold: 1000);

  late final FastTrackToButton _fastTrackToTwenty = FastTrackToButton(round: 20, gold: 1800);

  late final GoBackButton _goBackButton = GoBackButton(backFunction: () {
    world.worldStateManager.changeState(MainWorldState.mainMenu);
  });

  @override
  FutureOr<void> onLoad() {
    add(_startGame);

    var rollingButtons = [
      _continueGame,
      _fastTrackToTen,
      _fastTrackToFifteen,
      _fastTrackToTwenty,
      _goBackButton,
    ];

    Vector2 rollingPosition = _startGame.position;
    for (var button in rollingButtons) {
      rollingPosition += ThemingConstants.menuButtonGap;
      button.position = rollingPosition;
      add(button);
    }

    return super.onLoad();
  }
}
