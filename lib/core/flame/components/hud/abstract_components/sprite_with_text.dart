import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

// Component functions to try have a correctly aligned "icon" / sprite against a text.
// This will be used to conform HUD elements for consistency.
class SpriteWithText extends PositionComponent {
  static const gapBetween = 10;

  final SpriteComponent sprite;
  final TextComponent text;
  final double minimumGapBetween;

  SpriteWithText({required this.sprite, required this.text, this.minimumGapBetween = 30}) {
    _generateLabelPosition();
  }

  _generateLabelPosition() {
    // Given we are inside the component rendering, we just need to consider size and not absolute position.
    var rightSpritePosition = Vector2(sprite.scaledSize.x, sprite.scaledSize.y / 2);
    text.position = Vector2(max(rightSpritePosition.y, minimumGapBetween) + gapBetween, rightSpritePosition.y);
    text.anchor = Anchor.centerLeft;
  }

  @override
  FutureOr<void> onLoad() {
    add(sprite);
    add(text);
    return super.onLoad();
  }
}
