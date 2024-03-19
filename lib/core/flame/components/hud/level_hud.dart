import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/game_over_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/start_round_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/version_text.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class LevelHud extends PositionComponent with ParentIsA<MainWorld> {
  late final VersionText _versionText = VersionText()
    ..position = Vector2.all(15)
    ..anchor = Anchor.topLeft;

  late final FpsTextComponent _fpsText = FpsTextComponent(textRenderer: TextManager.basicHudRenderer)
    ..position = Vector2(_versionText.position.x, _versionText.y + 20)
    ..anchor = Anchor.topLeft
    ..scale = _versionText.scale;

  late final RoundText _roundText = RoundText()
    ..position = Vector2(parent.worldWidth / 2, 10)
    ..anchor = Anchor.topCenter;

  late final StartRoundButton _startRound = StartRoundButton()
    ..position = Vector2(parent.worldWidth / 2, parent.worldHeight / 4)
    ..anchor = Anchor.center;

  late final GameOverText _gameOverText = GameOverText()
    ..position = Vector2(parent.worldWidth / 2, parent.worldHeight / 4)
    ..anchor = Anchor.center;

  // TODO fix this positioning, the anchoring seems to not be working correctly.
  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = Vector2(parent.worldWidth - 130, 10)
    ..anchor = Anchor.topRight;

  int get currentRound => parent.currentRound;
  bool get roundOver => parent.roundOver;
  bool get gameOver => parent.gameOver;

  int get castleHealth => parent.castle.currentHealth;
  int get totalCastleHealth => parent.castle.totalHealth;

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);
    add(_roundText);
    add(_healthIndicator);
    add(_startRound);
    add(_gameOverText);

    return super.onLoad();
  }

  void startRound() {
    parent.roundManager.startNextRound();
    parent.entityManager.startSpawningRound();
  }
}
