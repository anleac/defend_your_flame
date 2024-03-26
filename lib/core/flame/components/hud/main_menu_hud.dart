import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/buttons/credits_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/load_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/start_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/title_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class MainMenuHud extends PositionComponent with HasWorldReference<MainWorld> {
  static final Vector2 _buttonGap = Vector2(0, 70);

  late final TitleText _titleText = TitleText()
    ..position = Vector2(world.worldWidth / 2, 80)
    ..anchor = Anchor.topCenter;

  late final StartGameButton _startGame = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3);

  late final LoadGameButton _loadGame = LoadGameButton()..position = _startGame.position + _buttonGap;

  late final CreditsButton _credits = CreditsButton()..position = _loadGame.position + _buttonGap;

  @override
  FutureOr<void> onLoad() {
    add(_titleText);
    add(_startGame);
    add(_loadGame);
    add(_credits);

    return super.onLoad();
  }

  void startRound() {
    world.roundManager.startNextRound();
  }
}
