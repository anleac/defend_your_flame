import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  static const double friction = 0.985;

  static final Vector2 gravity = Vector2(0, 22);
  static final Vector2 maxVelocity = Vector2(1000, 2000);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
