import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/helpers/damage_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

mixin HasDraggableCollisions on PositionComponent, CollisionCallbacks {
  DraggableEntity? _draggableEntity;
  DraggableEntity? get draggableEntity => _draggableEntity;

  bool get isCollidingWithDraggableEntity => _draggableEntity != null;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is DraggableEntity && DamageHelper.hasCollisionVelocityImpact(velocity: other.currentVelocity)) {
      _draggableEntity = other;
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  clearDraggableEntity({stopEntityDrag = false}) {
    if (stopEntityDrag) {
      _draggableEntity?.stopDraggingAndBounce();
    }

    _draggableEntity = null;
  }
}
