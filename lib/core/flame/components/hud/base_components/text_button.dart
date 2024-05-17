import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

// Flame doesn't currently expose a hover callback, so we can't implement it natively.
// We can implement it ourselves, but it's not a priority right now.
class TextButton extends TextComponent
    with TapCallbacks, HasVisibility, HoverCallbacks, HasGameReference<MainGame>, HasMouseHover {
  static final _underlinePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  static final _hoveredUnderlinePaint = _underlinePaint
    ..color = _underlinePaint.color.darken(ThemingConstants.hoveredDarken);

  final TextRenderer defaultTextRenderer;
  final TextRenderer hoveredTextRenderer;
  final TextRenderer disabledRenderer;

  final bool comingSoon;
  final bool underlined;
  bool _hovered = false;
  bool _canClick = true;

  TextButton({
    String text = '',
    Anchor anchor = Anchor.center,
    required this.defaultTextRenderer,
    required this.hoveredTextRenderer,
    required this.disabledRenderer,
    this.underlined = true,
    this.comingSoon = false,
  }) : super(
          text: text,
          textRenderer: defaultTextRenderer,
          anchor: anchor,
        );

  void toggleClickable(bool canClick) {
    _canClick = canClick;

    if (!canClick) {
      _hovered = false;
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point) && !comingSoon && _canClick;
  }

  @override
  void onMount() {
    if (comingSoon) {
      textRenderer = disabledRenderer;
      text = '$text ${ThemingConstants.comingSoonIndicator}';
    }

    super.onMount();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onPressed();
  }

  // This method is meant to be overridden by the user in the child classes.
  @mustCallSuper
  void onPressed() {
    resetCursor();
  }

  @override
  void onHoverEnter() {
    super.textRenderer = hoveredTextRenderer;
    _hovered = true;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() {
    if (!_hovered) {
      return;
    }

    super.textRenderer = defaultTextRenderer;
    _hovered = false;
    super.onHoverExit();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (underlined && !comingSoon && _canClick) {
      _drawUnderline(canvas);
    }
  }

  void _drawUnderline(Canvas canvas) {
    final lineStart = Offset(-10, scaledSize.y / 2 + 15);
    final lineEnd = Offset(scaledSize.x + 8, scaledSize.y / 2 + 15);
    canvas.drawLine(lineStart, lineEnd, _hovered ? _hoveredUnderlinePaint : _underlinePaint);
  }
}
