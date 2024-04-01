import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Draws an opaque black background with a grey rounded border around it.
class BorderedBackground extends PositionComponent with Snapshot {
  static final Paint _borderPaint = Paint()
    ..color = ThemingConstants.borderColour
    ..style = PaintingStyle.stroke;

  static final Paint _fillPaint = Paint()
    ..color = Colors.black.withOpacity(0.4)
    ..style = PaintingStyle.fill;

  final double borderThickness;
  final double borderRadius;
  final bool hasFill;

  BorderedBackground({
    this.borderThickness = 5,
    this.borderRadius = 10,
    this.hasFill = true,
  }) {
    renderSnapshot = true;
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    final borderRect = Rect.fromLTWH(
      borderThickness / 2,
      borderThickness / 2,
      width - borderThickness,
      height - borderThickness,
    );

    if (hasFill) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
        _fillPaint,
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(borderRect, Radius.circular(borderRadius)),
      _borderPaint,
    );
  }
}
