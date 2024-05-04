import 'package:flame/components.dart';

class PhysicsConstants {
  // Represented as a percentage of the velocity lost per second
  // X friction is higher as Y is generally influenced by gravity
  static final Vector2 friction = Vector2(0.90, 0.98);
  static final Vector2 gravity = Vector2(0, 2600.0);

  static final Vector2 magicalGravity = gravity / 8;
  static final Vector2 strongMagicalGravity = gravity / 4;

  static final Vector2 maxVelocity = Vector2(2000, 3000);
  static final Vector2 negativeMaxVelocity = -maxVelocity;
}
