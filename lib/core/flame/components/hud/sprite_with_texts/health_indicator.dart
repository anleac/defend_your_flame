import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/rock_heart.dart';
import 'package:defend_your_flame/core/flame/components/hud/abstract_components/sprite_with_text.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';
import 'package:flame/components.dart';

class HealthIndicator extends PositionComponent with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final RockHeart _rockHeart = RockHeart()..scale = Vector2.all(0.3);

  late final TextComponent _healthText = TextComponent(textRenderer: TextManager.basicHudRenderer);

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

  _setHealthText() {
    _healthText.text = TranslationHelper.insertNumbers(game.appStrings.healthIndicatorText,
        [world.playerManager.castle.currentHealth, world.playerManager.castle.totalHealth]);
  }
}
