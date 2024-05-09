import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/flying_entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/non_draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/projectiles/concrete_curving_projectiles/mage_curving_projectile.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class DeathReaper extends NonDraggableEntity with DisappearOnDeath {
  static final EntityConfig _baseEntityConfig = EntityConfig(
    entityResourceName: 'bosses/death_reaper',
    defaultSize: Vector2(140, 93),
    defaultScale: 1.6,
    walkingConfig: AnimationConfig(
      stepTime: 0.24,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.18,
      frames: 10,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.18,
      frames: 10,
    ),
    walkingForwardSpeed: 16,
    damageOnAttack: 20,
    goldOnKill: 30,
    totalHealth: DamageConstants.fallDamage * 10,
  );

  static final FlyingEntityConfig _deathReaperConfig = FlyingEntityConfig(
    entityConfig: _baseEntityConfig,
    idleConfig: AnimationConfig(
      stepTime: 0.26,
      frames: 8,
    ),
    attackRange: () => 0,
  );

  late final RectangleHitbox _hitbox = EntityHelper.createRectangleHitbox(
      size: Vector2(40, 54),
      anchor: Anchor.topCenter,
      position: Vector2(35, 38),
      collisionType: CollisionType.active,
      isSolid: true);

  DeathReaper({super.scaleModifier}) : super(flyingEntityConfig: _deathReaperConfig) {
    setDisappearSpeedFactor(2);
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

  @override
  void performAttack() {
    // We want it to come from the top right of the hitbox
    var attackPosition =
        _hitbox.absoluteTopLeftPosition + Vector2(_hitbox.width, 0) + (Vector2(8, -22) * scaleModifier);

    world.projectileManager.addProjectile(MageCurvingProjectile(
        initialPosition: attackPosition,
        targetPosition: world.playerBase.wall.absoluteCenter,
        damage: _baseEntityConfig.damageOnAttack));
  }

  static DeathReaper spawn({required Vector2 position}) {
    var scaleModifier = MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.2);
    var deathReaper = DeathReaper(scaleModifier: scaleModifier);

    deathReaper.position = position - Vector2(deathReaper.scaledSize.x / 2, deathReaper.scaledSize.y - 40);
    return deathReaper;
  }
}
