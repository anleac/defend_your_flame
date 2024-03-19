import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/rock_heart.dart';
import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';
import 'package:flame/components.dart';

class HealthIndicator extends PositionComponent with HasGameReference<MainGame>, ParentIsA<LevelHud> {
  late final RockHeart _rockHeart = RockHeart()
    ..position = Vector2(0, 0)
    ..scale = Vector2.all(0.3);

  late final TextComponent _healthText = TextComponent(textRenderer: TextManager.basicHudRenderer)
    ..position = Vector2(_rockHeart.scaledSize.x + 5, _rockHeart.scaledSize.y / 2)
    ..anchor = Anchor.centerLeft;

  @override
  FutureOr<void> onLoad() {
    add(_rockHeart);
    add(_healthText);
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
    _healthText.text = TranslationHelper.insertNumbers(
        game.appStrings.healthIndicatorText, [parent.castleHealth, parent.totalCastleHealth]);
  }
}
