import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/start_round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/version_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class LevelHud extends PositionComponent with ParentIsA<MainWorld> {
  late final VersionText _versionText = VersionText()
    ..position = Vector2(10, 10)
    ..anchor = Anchor.topLeft;

  late final FpsTextComponent _fpsText = FpsTextComponent()
    ..position = Vector2(_versionText.position.x, _versionText.y + 20)
    ..anchor = Anchor.topLeft
    ..scale = _versionText.scale;

  late final RoundText _roundText = RoundText()
    ..position = Vector2(parent.worldWidth / 2, 10)
    ..anchor = Anchor.topCenter;

  late final StartRound _startRound = StartRound()
    ..position = Vector2(parent.worldWidth / 2, parent.worldHeight / 4)
    ..anchor = Anchor.center;

  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = Vector2(parent.worldWidth - 10, 10)
    ..anchor = Anchor.topRight;

  int get currentRound => parent.currentRound;
  bool get roundOver => parent.roundOver;

  LevelHud() {
    position = Vector2(0, 0);
  }

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);
    add(_roundText);
    add(_healthIndicator);
    add(_startRound);

    return super.onLoad();
  }

  void startRound() {
    parent.roundManager.startNextRound();
    parent.entityManager.startSpawningRound();
  }
}
