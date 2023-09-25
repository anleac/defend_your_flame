import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class PhysicsHelper {
  // General helper function for when an entity is in freefall.
  static Vector2 applyGravityFrictionAndClamp(Vector2 velocity, double dt) {
    velocity = applyGravity(velocity, dt);
    velocity = applyFriction(velocity, dt);
    clampVelocity(velocity);
    return velocity;
  }

  static Vector2 applyGravity(Vector2 velocity, double dt) {
    return velocity + MiscHelper.vectorToDtScale(PhysicsConstants.gravity, dt);
  }

  static void clampVelocity(Vector2 velocity) {
    velocity.clamp(PhysicsConstants.negativeMaxVelocity, PhysicsConstants.maxVelocity);
  }

  static Vector2 applyFriction(Vector2 velocity, double dt) {
    return velocity * MiscHelper.doubleToDtScaleMult(PhysicsConstants.friction, dt);
  }
}
