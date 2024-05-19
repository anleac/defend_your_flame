import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/rock_heart.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/sprite_with_text.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class HealthIndicator extends PositionComponent with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final RockHeart _rockHeart = RockHeart()
    ..scale = Vector2.all(0.24)
    ..anchor = Anchor.center;

  late final TextComponent _healthText = TextComponent(textRenderer: TextManager.basicHudRenderer)
    ..anchor = Anchor.centerLeft;

  late final SpriteWithText _indicator = SpriteWithText(sprite: _rockHeart, text: _healthText);

  @override
  FutureOr<void> onLoad() {
    add(_indicator);
    return super.onLoad();
  }

  @override
  void onMount() {
    _setHealthText();
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _setHealthText();
  }

  _updateSizeOfParent() {
    size = _indicator.size;
  }

  _setHealthText() {
    var health = world.playerBase.wall.health.toString();
    _indicator.updateLabelText(health);
    _updateSizeOfParent();
  }
}
