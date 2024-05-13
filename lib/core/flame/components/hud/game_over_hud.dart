import 'dart:async';

import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/restart_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/game_over_text.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class GameOverHud extends BasicHud with HasGameReference<MainGame> {
  late final GameOverText _gameOverText = GameOverText()
    ..position = Vector2(world.worldWidth / 2, 80)
    ..anchor = Anchor.center;

  late final RestartGameButton _restartGameButton = RestartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 2)
    ..anchor = Anchor.center;

  late final TextComponent _roundText = TextComponent(
    text: '',
    textRenderer: TextManager.smallSubHeaderBoldRenderer,
  )
    ..position = (_gameOverText.center + _restartGameButton.center) / 2
    ..anchor = Anchor.center;

  @override
  void onMount() {
    _roundText.text = AppStringHelper.insertNumber(game.appStrings.gameOverRoundText, world.roundManager.currentRound);
    super.onMount();
  }

  @override
  FutureOr<void> onLoad() {
    add(_gameOverText);
    add(_restartGameButton);
    add(_roundText);

    return super.onLoad();
  }

  restartGame() {
    world.roundManager.resetGame();
    world.worldStateManager.changeState(MainWorldState.gameSelection);
  }
}
