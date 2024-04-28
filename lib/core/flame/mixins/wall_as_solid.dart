import 'package:defend_your_flame/core/flame/mixins/has_wall_collision.dart';
import 'package:flame/components.dart';

mixin WallAsSolid on HasWallCollision {
  double reboundDistance = 2;

  @override
  void update(double dt) {
    super.update(dt);

    if (isCollidingWithWall) {
      // Calculate the average intersection point
      Vector2 averageIntersectionPoint = Vector2.zero();
      for (Vector2 intersectionPoint in wallIntersectionPoints) {
        averageIntersectionPoint += intersectionPoint;
      }
      averageIntersectionPoint /= wallIntersectionPoints.length.toDouble();

      // Add a small "rebound" effect to push the entity away from the average intersection point
      position += (position - averageIntersectionPoint).normalized() * reboundDistance;
    }
  }
}
