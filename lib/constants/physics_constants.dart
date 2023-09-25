import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  static const double friction = 0.99;
  static final Vector2 gravity = Vector2(0, 0.7);

  static final Vector2 maxVelocity = Vector2(10, 25);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
