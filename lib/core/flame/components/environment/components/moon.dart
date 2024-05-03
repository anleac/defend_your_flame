import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/constants/experimental_constants.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/math_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Moon extends PositionComponent with TapCallbacks, GestureHitboxes, HasWorldReference<MainWorld> {
  final Paint _moonPaint = Paint()..color = Colors.white.withOpacity(0.4);

  final double _rotationalSpeed = MathHelper.degreesToRads(1);
  final double moonRadius = 30;

  final Vector2 _initialPosition = Vector2(-(Constants.desiredWidth * 0.1), Constants.desiredHeight);
  final Vector2 _rotateAround = Vector2(Constants.desiredWidth / 2, Constants.desiredHeight * 1.05);

  double _totalRotated = 0;

  Moon() {
    // Pre-rotate it a tad
    position = MathHelper.rotateAboutOrigin(_initialPosition, _rotateAround, MathHelper.degreesToRads(12));
  }

  @override
  Future<void> onLoad() {
    add(
      CircleHitbox(
        radius: moonRadius,
        collisionType: CollisionType.inactive,
      )
        ..paint = _moonPaint
        ..renderShape = true,
    );
    return super.onLoad();
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
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    if (ExperimentalConstants.allowMoonClickFastTrack) {
      world.moonClickFastTrack();
    }
  }
}
