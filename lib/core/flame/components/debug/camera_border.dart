// Renders a small line around the camera viewport border to help with debugging of the camera viewport.
import 'dart:ui';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:flame/components.dart';

class CameraBorder extends PositionComponent with HasGameReference {
  late final Paint _borderPaint = Paint()
    ..color = const Color(0x88ff0000)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  @override
  void render(Canvas canvas) {
    if (Constants.debugBuild) {
      canvas.drawRect(game.camera.visibleWorldRect, _borderPaint);
    }

    super.render(canvas);
  }
}
