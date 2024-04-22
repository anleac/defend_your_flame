import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

mixin HasWallCollision on PositionComponent, CollisionCallbacks {
  bool _isCollidingWithWall = false;
  bool _onTopOfWall = false;
  double _wallTopY = 0;

  bool get isCollidingWithWall => _isCollidingWithWall;
  bool get onTopOfWall => _onTopOfWall;
  double get wallTopY => _wallTopY;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Wall) {
      _isCollidingWithWall = true;

      // We can do a hacky calculation here to judge if the collision is on the top of the wall
      // By assuming at least 2 intersection points are needed, and they have the same y value
      // TODO revisit this post beta release
      _onTopOfWall = intersectionPoints.every((p) => MiscHelper.doubleEquals(p.y, intersectionPoints.first.y));

      if (_onTopOfWall) {
        _wallTopY = intersectionPoints.first.y;
      }
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
