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

class FireBeast extends NonDraggableEntity with DisappearOnDeath {
  static final EntityConfig _baseEntityConfig = EntityConfig(
    entityResourceName: 'bosses/fire_beast',
    defaultSize: Vector2(288, 160),
    defaultScale: 1.2,
    walkingConfig: AnimationConfig(
      stepTime: 0.15,
      frames: 12,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.16,
      frames: 15,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 22,
    ),
    walkingForwardSpeed: 16,
    damageOnAttack: 20,
    goldOnKill: 30,
    totalHealth: DamageConstants.fallDamage * 14,
  );

  static final FlyingEntityConfig _deathReaperConfig = FlyingEntityConfig(
    entityConfig: _baseEntityConfig,
    idleConfig: AnimationConfig(
      stepTime: 0.18,
      frames: 6,
    ),
    attackRange: () => 0,
  );

  late final RectangleHitbox _hitbox = EntityHelper.createRectangleHitbox(
      size: Vector2(80, 80),
      anchor: Anchor.topCenter,
      position: Vector2(145, 80),
      collisionType: CollisionType.active,
      isSolid: true);

  FireBeast({super.scaleModifier}) : super(flyingEntityConfig: _deathReaperConfig) {
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

  static FireBeast spawn({required Vector2 position}) {
    var scaleModifier = MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.2);
    var fireBeast = FireBeast(scaleModifier: scaleModifier);

    fireBeast.position = position - Vector2(fireBeast.scaledSize.x / 2, fireBeast.scaledSize.y - 40);
    return fireBeast;
  }
}
