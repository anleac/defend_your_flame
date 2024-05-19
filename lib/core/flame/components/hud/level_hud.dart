import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/flame_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/gold_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/version_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';

class LevelHud extends BasicHud {
  static const double padding = 15;
  static final Vector2 _hudScale = Vector2.all(1.2);

  static final Vector2 _topLeftTextGap = Vector2(0, 30);
  static final Vector2 _topRightTextGap = Vector2(0, 30);

  late final VersionText _versionText = VersionText()
    ..position = Vector2.all(padding)
    ..anchor = Anchor.topLeft
    ..scale = _hudScale;

  late final FpsTextComponent _fpsText = FpsTextComponent(textRenderer: TextManager.basicHudRenderer)
    ..position = _versionText.position + (_topLeftTextGap * _hudScale.y)
    ..anchor = Anchor.topLeft
    ..scale = _hudScale;

  late final RoundText _roundText = RoundText(betweenRoundsHud: betweenRoundsHud);

  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = Vector2(world.worldWidth - 15, padding)
    ..anchor = Anchor.topRight
    ..scale = Vector2.all(1.2);

  late final GoldIndicator _goldIndicator = GoldIndicator()
    ..position = _healthIndicator.position + (_topRightTextGap * _healthIndicator.scale.y)
    ..anchor = Anchor.topRight
    ..scale = _healthIndicator.scale;

  late final FlameIndicator _flameIndicator = FlameIndicator()
    ..position = _goldIndicator.position + (_topRightTextGap * _goldIndicator.scale.y)
    ..anchor = Anchor.topRight
    ..scale = _goldIndicator.scale;

  final bool betweenRoundsHud;

  LevelHud({this.betweenRoundsHud = false});

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);
    add(_roundText);
    add(_healthIndicator);
    add(_goldIndicator);
    add(_flameIndicator);

    return super.onLoad();
  }
}
