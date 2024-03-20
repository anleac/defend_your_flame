import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/buttons/start_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/title_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class MainMenuHud extends PositionComponent with HasWorldReference<MainWorld> {
  late final TitleText _titleText = TitleText()
    ..position = Vector2(world.worldWidth / 2, 80)
    ..anchor = Anchor.topCenter;

  late final StartGameButton _startGame = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_titleText);
    add(_startGame);
    return super.onLoad();
  }

  void startRound() {
    world.roundManager.startNextRound();
  }
}
