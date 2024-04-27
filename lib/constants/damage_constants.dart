import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:flame/components.dart';

class DamageConstants {
  static const double fallDamage = 10;

  static const double _fractionOfMaxVelocityForDamage = 0.9;
  static final Vector2 velocityThresholdForDamage = PhysicsConstants.maxVelocity * _fractionOfMaxVelocityForDamage;
}
