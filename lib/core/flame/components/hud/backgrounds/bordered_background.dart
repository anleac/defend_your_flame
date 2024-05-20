import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Draws an opaque black background with a grey rounded border around it.
class BorderedBackground extends PositionComponent with Snapshot {
  late Paint _borderPaint = Paint()
    ..color = borderColor
    ..strokeWidth = borderThickness
    ..style = PaintingStyle.stroke;

  late final Paint _fillPaint = Paint()
    ..color = fillColor.withOpacity(opacity)
    ..style = PaintingStyle.fill;

  final double borderThickness;
  final double borderRadius;
  final bool hasFill;
  final double opacity;

  Color borderColor;
  Color fillColor;

  BorderedBackground({
    this.borderThickness = 0.0,
    this.borderRadius = 10,
    this.hasFill = true,
    this.opacity = 0.5,
    this.borderColor = ThemingConstants.borderColour,
    this.fillColor = Colors.black,
  }) {
    renderSnapshot = true;
  }

  updateSize(Vector2 size) {
    this.size = size;
    takeSnapshot();
  }

  overrideBorderColour(Color colour) {
    if (borderColor == colour) return;

    borderColor = colour;
    _borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderThickness
      ..style = PaintingStyle.stroke;

    takeSnapshot();
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
