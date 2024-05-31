import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/helpers/hud_theming_helper.dart';
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

  final bool comingSoon;
  final bool underlined;

  bool _hovered = false;
  bool _canClick = true;
  bool _isSelected = false;

  TextButton({
    String text = '',
    Anchor anchor = Anchor.center,
    required this.defaultTextRenderer,
    this.underlined = true,
    this.comingSoon = false,
  }) : super(
          text: text,
          textRenderer: defaultTextRenderer,
          anchor: anchor,
        );

  void toggleClickable(bool canClick) {
    _canClick = canClick;

    if (!canClick && _hovered) {
      _removeEffect();
      _hovered = false;
    }
  }

  void setSelected(bool selected) {
    if (_isSelected == selected) {
      return;
    }

    _isSelected = selected;

    decorator.removeLast();
    if (selected) {
      decorator.replaceLast(HudThemingHelper.hoveredDecorator);
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point) && !comingSoon && _canClick;
  }

  @override
  void onMount() {
    if (comingSoon) {
      decorator.replaceLast(HudThemingHelper.disabledDecorator);
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
    _addHoverEffect();
    _hovered = true;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() {
    _removeEffect();

    if (!_hovered) {
      return;
    }

    _hovered = false;
    super.onHoverExit();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if ((underlined && !comingSoon && _canClick) || _isSelected) {
      _drawUnderline(canvas);
    }
  }

  void _addHoverEffect() {
    if (_isSelected) {
      return;
    }

    decorator.replaceLast(HudThemingHelper.hoveredDecorator);
  }

  void _removeEffect() {
    if (_isSelected) {
      return;
    }

    decorator.removeLast();
  }

  void _drawUnderline(Canvas canvas) {
    final verticalOffset = size.y / 2 + 20;
    final lineStart = Offset(-10, verticalOffset);
    final lineEnd = Offset(size.x + 8, verticalOffset);
    canvas.drawLine(lineStart, lineEnd, _hovered ? _hoveredUnderlinePaint : _underlinePaint);
  }
}
