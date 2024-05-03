import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';

class PhysicsHelper {
  static Vector2 applyGravity(Vector2 velocity, double dt) {
    return TimestepHelper.addVector2(velocity, PhysicsConstants.gravity, dt);
  }

  static Vector2 applyCustomGravity(Vector2 velocity, Vector2 gravity, double dt) {
    return TimestepHelper.addVector2(velocity, gravity, dt);
  }

  static void clampVelocity(Vector2 velocity) {
    velocity.clamp(PhysicsConstants.negativeMaxVelocity, PhysicsConstants.maxVelocity);
  }

  static Vector2 applyFriction(Vector2 velocity, double dt) {
    return TimestepHelper.multiplyVector2(velocity, PhysicsConstants.friction, dt);
  }

  static bool pointIsInsideBounds({required Vector2 point, required Vector2 size, Vector2? position, Vector2? offset}) {
    position ??= Vector2.zero();
    offset ??= Vector2.zero();
    return point.x >= position.x + offset.x &&
        point.x <= position.x + size.x + offset.x &&
        point.y >= position.y + offset.y &&
        point.y <= position.y + size.y + offset.y;
  }

  static Vector2 calculateVelocityToTarget(
      {required Vector2 initialPosition,
      required Vector2 targetPosition,
      required double horizontalPixelsPerSecond,
      required Vector2 gravity,
      double targetXVelocity = 0}) {
    // Calculate the relative horizontal speed
    double relativeHorizontalSpeed = horizontalPixelsPerSecond - targetXVelocity;

    // Calculate the distance to the target
    double distanceX = targetPosition.x - initialPosition.x;
    double distanceY = targetPosition.y - initialPosition.y;

    // Calculate the time it will take to reach the target
    double time = distanceX.abs() / relativeHorizontalSpeed;

    // Calculate the y velocity needed to reach the target in the given time, taking into account the effect of gravity
    double vy = distanceY / time - 0.5 * gravity.y * time;

    return Vector2(relativeHorizontalSpeed * (distanceX >= 0 ? 1 : -1), vy);
  }
}
