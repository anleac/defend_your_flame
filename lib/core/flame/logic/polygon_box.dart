import 'package:defend_your_flame/constants/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

mixin PolygonBox on PositionComponent {
  List<Vector2> _boundingPolygon = [];

  List<Vector2> get boundingPolygon => _boundingPolygon;

  void setBoundingPolygon(List<Vector2> polygon) {
    _boundingPolygon = polygon;
  }

  void renderPolygonBox(Canvas canvas) {
    if (_boundingPolygon.isEmpty || !Constants.debugBuild) {
      return;
    }

    final paint = Paint()
      ..color = const Color(0xFFFF00FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();
    var realPoints = _boundingPolygon.map(_outScaledPoint).toList();

    path.moveTo(realPoints.first.x, realPoints.first.y);
    for (final point in realPoints) {
      path.lineTo(point.x, point.y);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  Vector2 _outScaledPoint(Vector2 point) {
    return Vector2(point.x / scale.x, point.y / scale.y);
  }
}
