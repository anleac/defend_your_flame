import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

mixin HasWallCollision on PositionComponent, CollisionCallbacks {
  bool _isCollidingWithWall = false;
  bool get isCollidingWithWall => _isCollidingWithWall;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Wall) {
      _isCollidingWithWall = true;
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Wall) {
      _isCollidingWithWall = false;
    }

    super.onCollisionEnd(other);
  }
}
