import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/flame_icon.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/sprite_with_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class FlameIndicator extends PositionComponent with HasWorldReference<MainWorld> {
  late final FlameIcon _flame = FlameIcon()
    ..scale = Vector2.all(0.5)
    ..anchor = Anchor.center;

  late final TextComponent _flameText = TextComponent(textRenderer: TextManager.basicHudRenderer)
    ..anchor = Anchor.centerLeft;

  late final SpriteWithText _indicator = SpriteWithText(sprite: _flame, text: _flameText, leftOffset: 6);

  @override
  FutureOr<void> onLoad() {
    add(_indicator);
    return super.onLoad();
  }

  @override
  void onMount() {
    _setFlameText();
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _setFlameText();
  }

  _updateSizeOfParent() {
    size = _indicator.size;
  }

  _setFlameText() {
    var flameLevel = world.playerBase.flameMana.toString();
    _indicator.updateLabelText(flameLevel);
    _updateSizeOfParent();
  }
}
