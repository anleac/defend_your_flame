import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class StrongSkeleton extends DraggableEntity {
  static final EntityConfig _strongSkeletonConfig = EntityConfig(
    entityResourceName: 'strong_skeleton',
    defaultSize: Vector2(64, 64),
    collisionOffset: Vector2(20, 16),
    collisionSize: Vector2(24, 33),
    defaultScale: 1.5,
    walkingConfig: AnimationConfig(frames: 12, stepTime: 0.15),
    attackingConfig: AnimationConfig(frames: 13, stepTime: 0.11),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.16),
    dyingConfig: AnimationConfig(frames: 13, stepTime: 0.12),
    damageOnAttack: 15,
    extraXBoundaryOffset: -40,
    goldOnKill: 12,
    walkingForwardSpeed: 19,
    // Let him survive two falls
    totalHealth: DamageConstants.fallDamage * 2,
    dragResistance: 0.48,
  );

  StrongSkeleton({super.scaleModifier}) : super(entityConfig: _strongSkeletonConfig);

  @override
  Vector2? attackEffectPosition() {
    return position + scaledSize / 2;
  }

  static StrongSkeleton spawn({required position}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final skeleton = StrongSkeleton(scaleModifier: scaleModifier);
    skeleton.position = position - Vector2(skeleton.scaledSize.x, skeleton.scaledSize.y / 2);
    return skeleton;
  }
}
