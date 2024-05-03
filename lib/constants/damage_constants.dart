import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:flame/components.dart';

class DamageConstants {
  // We also base the health of most entities on the fall damage.
  // This is because the basic entities should die from a fall from a certain height.
  static const double fallDamage = 10;

  static const double wallImpactDamage = 5;
  static const double collisionDamage = 8;

  static const double clickingDamage = 2;

  static const double _fractionOfMaxVelocityForDragDamage = 0.45;
  static const double _fractionOfMaxVelocityForFallDamage = 0.4;
  static const double _fractionOfMaxVelocityForCollisionDamage = 0.3;

  static final Vector2 velocityThresholdForDragDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForDragDamage;

  static final Vector2 velocityThresholdForFallDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForFallDamage;

  static final Vector2 velocityThresholdForCollisionDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForCollisionDamage;
}
