import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/version_text.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class LevelHud extends PositionComponent with ParentIsA<MainWorld> {
  late final VersionText _versionText = VersionText()
    ..position = Vector2(parent.worldWidth - 10, 10)
    ..anchor = Anchor.topRight;

  late final FpsTextComponent _fpsText = FpsTextComponent()
    ..position = Vector2(parent.worldWidth - 10, _versionText.y + 20)
    ..anchor = Anchor.topRight
    ..scale = _versionText.scale;

  LevelHud() {
    position = Vector2(0, 0);
  }

  @override
  FutureOr<void> onLoad() {
    add(_versionText);
    add(_fpsText);

    return super.onLoad();
  }
}
