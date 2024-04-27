import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/helpers/math_helper.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Moon extends PositionComponent {
  final double _rotationalSpeed = MathHelper.degreesToRads(1);
  final double moonRadius = 30;

  final Vector2 _initialPosition = Vector2(-(Constants.desiredWidth * 0.1), Constants.desiredHeight);
  final Vector2 _rotateAround = Vector2(Constants.desiredWidth / 2, Constants.desiredHeight * 1.05);

  double _totalRotated = 0;

  Moon() {
    // Pre-rotate it a tad
    position = MathHelper.rotateAboutOrigin(_initialPosition, _rotateAround, MathHelper.degreesToRads(10));
  }

  @override
  void update(double dt) {
    var toRotate = dt * _rotationalSpeed;

    position = MathHelper.rotateAboutOrigin(position, _rotateAround, toRotate);

    _totalRotated += MathHelper.radsToDegrees(toRotate);
    if (_totalRotated > 170) {
      _totalRotated = 0;
      position = _initialPosition;
    }

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, moonRadius, Paint()..color = Colors.white.withOpacity(0.4));
    super.render(canvas);
  }
}
