import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:flame/components.dart';

class DamageConstants {
  static const double fallDamage = 10;

  static const double _fractionOfMaxVelocityForDragDamage = 0.8;
  static const double _fractionOfMaxVelocityForFallDamage = 0.5;

  static final Vector2 velocityThresholdForDragDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForDragDamage;

  static final Vector2 velocityThresholdForFallDamage =
      PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForFallDamage;
}
