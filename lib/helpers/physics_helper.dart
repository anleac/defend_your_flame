import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';

class PhysicsHelper {
  static Vector2 applyGravity(Vector2 velocity, double dt) {
    return TimestepHelper.addVector2(velocity, PhysicsConstants.gravity, dt);
  }

  static Vector2 applyMagicalGravity(Vector2 velocity, double dt) {
    return TimestepHelper.addVector2(velocity, PhysicsConstants.magicalGravity, dt);
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
      required Vector2 gravity}) {
    // Calculate the distance to the target
    double distanceX = targetPosition.x - initialPosition.x;
    double distanceY = targetPosition.y - initialPosition.y;

    double time = distanceX / horizontalPixelsPerSecond;

    double vx = distanceX / time;
    double vy = (distanceY - 0.5 * gravity.y * time * time) / time;

    return Vector2(vx, vy);
  }
}
