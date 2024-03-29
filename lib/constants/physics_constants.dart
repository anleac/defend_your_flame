import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  static const double friction = 0.75;
  static final Vector2 gravity = Vector2(0, 1500.0);

  static final Vector2 maxVelocity = Vector2(400, 2500);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
