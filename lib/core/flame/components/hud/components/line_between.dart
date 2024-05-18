import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LineBetween extends PositionComponent with Snapshot {
  late final Paint _paint = Paint()
    ..color = Colors.white70
    ..strokeWidth = thickness
    ..style = PaintingStyle.stroke;

  final double thickness;
  final Vector2 start;
  final Vector2 end;

  LineBetween({
    required this.start,
    required this.end,
    this.thickness = 7,
  }) {
    renderSnapshot = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(start.toOffset(), end.toOffset(), _paint);
  }
}
