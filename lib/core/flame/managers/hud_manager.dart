import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/game_over_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/main_menu_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class HudManager extends PositionComponent with HasWorldReference<MainWorld> {
  final MainMenuHud _mainMenuHud = MainMenuHud();
  final LevelHud _levelHud = LevelHud();
  final NextRoundHud _nextRoundHud = NextRoundHud();
  final GameOverHud _gameOverHud = GameOverHud();

  MainWorldState _previousState = MainWorldState.mainMenu;

  @override
  FutureOr<void> onLoad() {
    // The initial state of the game is the main menu
    add(_mainMenuHud);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (world.worldStateManager.currentState != _previousState) {
      _previousState = world.worldStateManager.currentState;
      _updateHud();
    }
  }

  void _updateHud() {
    for (var element in children) {
      element.removeFromParent();
    }

    switch (world.worldStateManager.currentState) {
      case MainWorldState.mainMenu:
        add(_mainMenuHud);
        break;
      case MainWorldState.playing:
        add(_levelHud);
        break;
      case MainWorldState.betweenRounds:
        add(_nextRoundHud);
        break;
      case MainWorldState.gameOver:
        add(_gameOverHud);
        break;
    }
  }
}
