import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  // X friction is higher as Y is generally influenced by gravity
  static final Vector2 friction = Vector2(0.82, 0.96);
  static final Vector2 gravity = Vector2(0, 3000.0);

  static final Vector2 magicalGravity = gravity / 5;
  static final Vector2 strongMagicalGravity = gravity / 2;

  static final Vector2 maxVelocity = Vector2(2000, 3000);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
