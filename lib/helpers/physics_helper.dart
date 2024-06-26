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
    velocity.x = TimestepHelper.multiply(velocity.x, PhysicsConstants.friction.x, dt);
    velocity.y = TimestepHelper.multiply(velocity.y, PhysicsConstants.friction.y, dt);
    return velocity;
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
    double distanceX = targetPosition.x - initialPosition.x;
    double time = distanceX.abs() / horizontalPixelsPerSecond;

    double distanceY = targetPosition.y - initialPosition.y;

    double vy = distanceY / time - 0.5 * gravity.y * time;
    double vx = horizontalPixelsPerSecond * (distanceX >= 0 ? 1 : -1) + targetXVelocity;

    return Vector2(vx, vy);
  }
}
