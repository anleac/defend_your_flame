import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class StrongSkeleton extends DraggableEntity with DisappearOnDeath {
  static final EntityConfig _strongSkeletonConfig = EntityConfig(
    entityResourceName: 'strong_skeleton',
    defaultSize: Vector2(64, 64),
    defaultScale: 1.65,
    walkingConfig: AnimationConfig(frames: 12, stepTime: 0.15),
    attackingConfig: AnimationConfig(frames: 13, stepTime: 0.11),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.16),
    dyingConfig: AnimationConfig(frames: 13, stepTime: 0.14),
    damageOnAttack: 15,
    goldOnKill: 8,
    walkingForwardSpeed: 19,
    totalHealth: DamageConstants.fallDamage * 2,
    dragResistance: 0.55,
  );

  late final RectangleHitbox _hitbox =
      EntityHelper.createRectangleHitbox(size: Vector2(24, 33), position: Vector2(30, 48), anchor: Anchor.bottomCenter);

  StrongSkeleton({super.scaleModifier}) : super(entityConfig: _strongSkeletonConfig);

  @override
  Vector2? attackEffectPosition() {
    return position + scaledSize / 2;
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [_hitbox];
  }

  @override
  void render(Canvas canvas) {
    EntityHelper.drawHealthBar(canvas,
        entity: this, width: _hitbox.width, centerPosition: Vector2(_hitbox.center.x, _hitbox.topLeftPosition.y));

    super.render(canvas);
  }

  static StrongSkeleton spawn({required position}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final skeleton = StrongSkeleton(scaleModifier: scaleModifier);
    skeleton.position = position - Vector2(skeleton.scaledSize.x, skeleton.scaledSize.y / 2);
    return skeleton;
  }
}
