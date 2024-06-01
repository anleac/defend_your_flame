import 'dart:async';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/credits_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/how_to_play_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/menu/select_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/title_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/version_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class MainMenuHud extends BasicHud {
  late final TitleText _titleText = TitleText()
    ..position = Vector2(world.worldWidth / 2, 100)
    ..anchor = Anchor.topCenter;

  late final SelectGameButton _selectGame = SelectGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3 + 20);

  late final HowToPlayButton _howToPlay = HowToPlayButton()
    ..position = _selectGame.position + ThemingConstants.menuButtonGap;

  late final CreditsButton _credits = CreditsButton()..position = _howToPlay.position + ThemingConstants.menuButtonGap;

  late final VersionText _versionText = VersionText()
    ..position = _credits.position + ThemingConstants.menuButtonGap / 1.5
    ..scale = Vector2.all(0.7)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_titleText);
    add(_selectGame);
    add(_howToPlay);
    add(_credits);
    add(_versionText);

    return super.onLoad();
  }

  void goToGameSelection() {
    world.worldStateManager.changeState(MainWorldState.gameSelection);
  }
}
