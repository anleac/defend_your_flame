import 'dart:async';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/credits_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/how_to_play_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/load_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/start_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/title_text.dart';
import 'package:flame/components.dart';

class MainMenuHud extends BasicHud {
  late final TitleText _titleText = TitleText()
    ..position = Vector2(world.worldWidth / 2, 80)
    ..anchor = Anchor.topCenter;

  late final StartGameButton _startGame = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3);

  late final LoadGameButton _loadGame = LoadGameButton()
    ..position = _startGame.position + ThemingConstants.menuButtonGap;

  late final HowToPlayButton _howToPlay = HowToPlayButton()
    ..position = _loadGame.position + ThemingConstants.menuButtonGap;

  late final CreditsButton _credits = CreditsButton()..position = _howToPlay.position + ThemingConstants.menuButtonGap;

  @override
  FutureOr<void> onLoad() {
    add(_titleText);
    add(_startGame);
    add(_loadGame);
    add(_howToPlay);
    add(_credits);

    return super.onLoad();
  }

  void startRound() {
    world.roundManager.startNextRound();
  }
}
