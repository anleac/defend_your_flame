import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_idle_time.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class RockGolem extends DraggableEntity with DisappearOnDeath, HasIdleTime {
  static final EntityConfig _rockGolemConfig = EntityConfig(
    entityResourceName: 'rock_golem',
    defaultSize: Vector2(90, 64),
    defaultScale: 1.45,
    walkingConfig: AnimationConfig(frames: 10, stepTime: 0.16),
    attackingConfig: AnimationConfig(frames: 11, stepTime: 0.14),
    dragConfig: AnimationConfig(frames: 8, stepTime: 0.16),
    idleConfig: AnimationConfig(frames: 8, stepTime: 0.14),
    dyingConfig: AnimationConfig(frames: 13, stepTime: 0.12),
    damageOnAttack: 15,
    goldOnKill: 8,
    baseWalkingSpeed: 20,
    totalHealth: DamageConstants.fallDamage * 4,
    dragResistance: 0.52,
    timeSpendIdle: TimeSpendIdle.minimal,
    magicImmune: true,
  );

  late final RectangleHitbox _hitbox =
      EntityHelper.createRectangleHitbox(size: Vector2(35, 33), position: Vector2(44, 64), anchor: Anchor.bottomCenter);

  RockGolem({super.scaleModifier, super.modifiedWalkingSpeed}) : super(entityConfig: _rockGolemConfig);

  @override
  Vector2? attackEffectPosition() {
    return trueCenter + Vector2(scaledSize.x / 2 - 3, 0);
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

  static RockGolem spawn({required Vector2 position, required double speedFactor}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final golem = RockGolem(scaleModifier: scaleModifier);
    golem.position = position - Vector2(golem.scaledSize.x, golem.scaledSize.y / 2);
    return golem;
  }
}
