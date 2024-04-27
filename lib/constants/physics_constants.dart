import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  static const double friction = 0.95;
  static final Vector2 gravity = Vector2(0, 2600.0);

  static final Vector2 magicalGravity = Vector2(0, 400.0);

  static final Vector2 maxVelocity = Vector2(2000, 3000);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
