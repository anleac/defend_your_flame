import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/rock_heart.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';
import 'package:flame/components.dart';

class HealthIndicator extends PositionComponent with HasGameReference<MainGame> {
  late final RockHeart _rockHeart = RockHeart()
    ..position = Vector2(0, 0)
    ..scale = Vector2.all(0.3);

  late final TextComponent _healthText = TextComponent()
    ..position = Vector2(_rockHeart.position.x + _rockHeart.scaledSize.x + 40, _rockHeart.scaledSize.y / 2)
    ..anchor = Anchor.center
    ..scale = Vector2.all(0.8);

  @override
  FutureOr<void> onLoad() {
    add(_rockHeart);
    add(_healthText);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _setHealthText();
  }

  _setHealthText() {
    _healthText.text = TranslationHelper.insertNumbers(game.appStrings.healthIndicatorText, [100, 100]);
  }
}
