import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:flame/components.dart';

class Skeleton extends DraggableEntity {
  static final EntityConfig _skeletonConfig = EntityConfig(
    entityResourceName: 'skeleton',
    defaultSize: Vector2(22, 33),
    attackingSize: Vector2(43, 37),
    attackingCollisionOffset: Vector2(5, 0),
    collisionSize: Vector2(16, 25),
    defaultScale: 1.2,
    walkingConfig: AnimationConfig(frames: 13, stepTime: 0.08),
    attackingConfig: AnimationConfig(frames: 18, stepTime: 0.1),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 15, stepTime: 0.07),
    damageOnAttack: 8,
    goldOnKill: 5,
    walkingForwardSpeed: 27,
    collisionAnchor: Anchor.bottomLeft,
  );

  Skeleton({super.scaleModifier}) : super(entityConfig: _skeletonConfig) {
    // We use the bottom left anchor because the attack animation is larger than the walking one, to stop the skeleton from moving when attacking.
    anchor = Anchor.bottomLeft;
  }

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x - 10, -scaledSize.y / 2);
  }

  static Skeleton spawn({required position, required scaleModifier}) {
    final skeleton = Skeleton(scaleModifier: scaleModifier);

    // Since we are using the bottom left anchor, we need to adjust the position.
    skeleton.position = position + Vector2(-skeleton.scaledSize.x, skeleton.scaledSize.y);
    return skeleton;
  }
}
