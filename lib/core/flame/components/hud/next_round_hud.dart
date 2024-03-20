import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/buttons/next_round_button.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class NextRoundHud extends PositionComponent with HasWorldReference<MainWorld> {
  late final NextRoundButton _nextRound = NextRoundButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4)
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_nextRound);
    return super.onLoad();
  }

  void startNextRound() {
    world.roundManager.startNextRound();
  }
}
