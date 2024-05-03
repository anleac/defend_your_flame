import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class HorizontalDivider extends PositionComponent with Snapshot {
  static final Paint _paint = Paint()
    ..color = ThemingConstants.borderColour.withOpacity(0.7)
    ..style = PaintingStyle.fill;

  final double padding;

  HorizontalDivider({this.padding = 0}) {
    renderSnapshot = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var renderRect = Rect.fromLTWH(padding, 0, size.x - padding * 2, size.y);
    canvas.drawRect(renderRect, _paint);
  }
}
