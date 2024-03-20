import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/text/game_over_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class GameOverHud extends PositionComponent with HasWorldReference<MainWorld> {
  late final GameOverText _gameOverText = GameOverText()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_gameOverText);

    return super.onLoad();
  }
}
