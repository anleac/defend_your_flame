import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/text/start_game_button.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class NextRoundHud extends PositionComponent with HasWorldReference<MainWorld> {
  late final StartGameButton _startRound = StartGameButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_startRound);
    return super.onLoad();
  }

  void startNextRound() {
    world.roundManager.startNextRound();
  }
}
