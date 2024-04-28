import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:flame/components.dart';

class DamageHelper {
  static bool hasDragVelocityImpact({required Vector2 velocity, required bool considerHorizontal}) {
    var yImpact = velocity.y.abs() > DamageConstants.velocityThresholdForDragDamage.y;

    if (!considerHorizontal) {
      return yImpact;
    }

    var xImpact = velocity.x.abs() > DamageConstants.velocityThresholdForDragDamage.x;
    return yImpact || xImpact;
  }

  static bool hasFallVelocityImpact({required Vector2 velocity}) {
    return velocity.y.abs() > DamageConstants.velocityThresholdForFallDamage.y;
  }
}
