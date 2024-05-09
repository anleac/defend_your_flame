import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/helpers/damage_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

mixin HasDraggableCollisions on Entity, CollisionCallbacks {
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is DraggableEntity && DamageHelper.hasCollisionVelocityImpact(velocity: other.currentVelocity)) {
      onDraggableEntityColission(other);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void onDraggableEntityColission(DraggableEntity other) {
    takeDamage(DamageConstants.collisionDamage);
    other.takeDamage(DamageConstants.collisionDamage);

    other.stopDraggingAndBounce();
  }
}
