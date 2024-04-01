import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/gold_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/version_text.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class LevelHud extends BasicHud {
  static final Vector2 _topLeftTextGap = Vector2(0, 30);
  static final Vector2 _topRightTextGap = Vector2(0, 35);

  late final VersionText _versionText = VersionText()
    ..position = Vector2.all(20)
    ..anchor = Anchor.topLeft;

  late final FpsTextComponent _fpsText = FpsTextComponent(textRenderer: TextManager.basicHudRenderer)
    ..position = _versionText.position + _topLeftTextGap
    ..anchor = Anchor.topLeft
    ..scale = _versionText.scale;

  late final RoundText _roundText = RoundText()
    ..position = Vector2(world.worldWidth / 2, 20)
    ..anchor = Anchor.topCenter;

  late final HealthIndicator _healthIndicator = HealthIndicator()..position = Vector2(world.worldWidth - 90, 15);

  late final GoldIndicator _goldIndicator = GoldIndicator()..position = _healthIndicator.position + _topRightTextGap;

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);
    add(_roundText);
    add(_healthIndicator);
    add(_goldIndicator);

    return super.onLoad();
  }
}
