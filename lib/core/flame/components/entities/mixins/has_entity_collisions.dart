import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

mixin HasEntityCollisions on PositionComponent, CollisionCallbacks {
  Entity? _collidedEntity;
  Entity? get collidedEntity => _collidedEntity;

  bool get isCollidingWithEntity => _collidedEntity != null;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Entity) {
      _collidedEntity = other;
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Entity) {
      // This isn't very reliable, as this wont work if there are multiple entities colliding at the same time
      _collidedEntity = null;
    }

    super.onCollisionEnd(other);
  }
}
