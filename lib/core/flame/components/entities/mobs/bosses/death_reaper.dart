import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_draggable_collisions.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_idle_time.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class DeathReaper extends Entity with DisappearOnDeath, HasDraggableCollisions, HasIdleTime {
  static final EntityConfig _deathReaperConfig = EntityConfig(
    entityResourceName: 'bosses/death_reaper',
    defaultSize: Vector2(140, 93),
    defaultScale: 1.65,
    idleConfig: AnimationConfig(
      stepTime: 0.2,
      frames: 8,
    ),
    walkingConfig: AnimationConfig(
      stepTime: 0.25,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.20,
      frames: 10,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.16,
      frames: 10,
    ),
    baseWalkingSpeed: 14,
    damageOnAttack: 20,
    goldOnKill: 40,
    totalHealth: DamageConstants.fallDamage * 20,
    timeSpendIdle: TimeSpendIdle.minimal,
    attackRange: () => 48,
  );

  late final RectangleHitbox _hitbox = EntityHelper.createRectangleHitbox(
      size: Vector2(40, 54),
      anchor: Anchor.topCenter,
      position: Vector2(35, 38),
      collisionType: CollisionType.active,
      isSolid: true);

  DeathReaper({super.scaleModifier}) : super(entityConfig: _deathReaperConfig);

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

  static DeathReaper spawn({required Vector2 position}) {
    var scaleModifier = MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.2);
    var deathReaper = DeathReaper(scaleModifier: scaleModifier);

    deathReaper.position = position - Vector2(deathReaper.scaledSize.x / 3, deathReaper.scaledSize.y - 40);
    return deathReaper;
  }
}
