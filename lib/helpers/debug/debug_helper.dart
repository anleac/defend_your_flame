import 'dart:ui';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';

class DebugHelper {
  static void drawEntityCollisionBox(Canvas canvas, Entity entity) {
    if (!Constants.debugBuild) {
      return;
    }

    final paint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      entity.localCollisionRect,
      paint,
    );
  }
}
