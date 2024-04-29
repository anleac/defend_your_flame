import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:flame/components.dart';

class DamageConstants {
  static const double fallDamage = 10;

  static const double wallImpactDamage = fallDamage / 2;
  static const double collisionDamage = fallDamage / 2;

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
