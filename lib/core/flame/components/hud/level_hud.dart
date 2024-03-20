import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/complex/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/round_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/version_text.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class LevelHud extends PositionComponent with HasWorldReference<MainWorld> {
  late final VersionText _versionText = VersionText()
    ..position = Vector2.all(15)
    ..anchor = Anchor.topLeft;

  late final FpsTextComponent _fpsText = FpsTextComponent(textRenderer: TextManager.basicHudRenderer)
    ..position = Vector2(_versionText.position.x, _versionText.y + 20)
    ..anchor = Anchor.topLeft
    ..scale = _versionText.scale;

  late final RoundText _roundText = RoundText()
    ..position = Vector2(world.worldWidth / 2, 10)
    ..anchor = Anchor.topCenter;

  // TODO fix this positioning, the anchoring seems to not be working correctly.
  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = Vector2(world.worldWidth - 130, 10)
    ..anchor = Anchor.topRight;

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);
    add(_roundText);
    add(_healthIndicator);

    return super.onLoad();
  }
}
