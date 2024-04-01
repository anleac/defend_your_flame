import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/restart_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/game_over_text.dart';
import 'package:flame/components.dart';

class GameOverHud extends BasicHud {
  late final GameOverText _gameOverText = GameOverText()
    ..position = Vector2(world.worldWidth / 2, 80)
    ..anchor = Anchor.center;

  late final RestartGameButton _restartGameButton = RestartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_gameOverText);
    add(_restartGameButton);

    return super.onLoad();
  }

  restartGame() {
    world.roundManager.restartGame();
  }
}
