import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:flame/components.dart';

class DamageConstants {
  static const double fallDamage = 10;

  static const double wallImpactDamage = fallDamage / 2;

  static const double _fractionOfMaxVelocityForDragDamage = 0.5;
  static const double _fractionOfMaxVelocityForFallDamage = 0.4;

  static final Vector2 velocityThresholdForDragDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForDragDamage;

  static final Vector2 velocityThresholdForFallDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForFallDamage;
}
