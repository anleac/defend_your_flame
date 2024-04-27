import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:flame/components.dart';

class DamageHelper {
  static bool hasVelocityImpact({required Vector2 velocity, required bool considerHorizontal}) {
    var yImpact = velocity.y.abs() > DamageConstants.velocityThresholdForDamage.y;

    if (!considerHorizontal) {
      return yImpact;
    }

    var xImpact = velocity.x.abs() > DamageConstants.velocityThresholdForDamage.x;
    return yImpact || xImpact;
  }
}
