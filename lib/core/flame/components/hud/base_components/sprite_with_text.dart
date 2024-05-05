import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

// Component functions to try have a correctly aligned "icon" / sprite against a text.
// This will be used to conform HUD elements for consistency.
class SpriteWithText extends PositionComponent {
  static const double gapBetween = 8;

  final SpriteComponent sprite;
  final TextComponent text;
  final double minimumWidth;

  SpriteWithText({required this.sprite, required this.text, this.minimumWidth = 70}) {
    _generateLabelPosition();
  }

  void _generateLabelPosition() {
    var height = max(text.scaledSize.y, sprite.scaledSize.y);

    sprite.position = Vector2(0, height / 2);

    var gap = max(gapBetween, minimumWidth - sprite.scaledSize.x - text.scaledSize.x);
    text.position = Vector2(sprite.scaledSize.x + gap, height / 2);

    size = Vector2(max(minimumWidth, sprite.scaledSize.x + gap + text.scaledSize.x), height);
  }

  updateLabelText(String newText) {
    if (text.text == newText) return;

    text.text = newText;
    _generateLabelPosition();
  }

  @override
  FutureOr<void> onLoad() {
    add(sprite);
    add(text);
    return super.onLoad();
  }
}
