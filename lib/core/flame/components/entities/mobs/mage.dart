import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/flying_entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/flying_entity.dart';
import 'package:defend_your_flame/core/flame/components/projectiles/curving_magic_projectile.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Mage extends FlyingEntity with DisappearOnDeath {
  static final EntityConfig _baseEntityConfig = EntityConfig(
    entityResourceName: 'mage',
    defaultSize: Vector2(160, 128),
    defaultScale: 1.2,
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.14,
      frames: 13,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.07,
      frames: 8,
    ),
    walkingForwardSpeed: 34,
    damageOnAttack: 12,
    goldOnKill: 15,
    totalHealth: DamageConstants.fallDamage * 4,
  );

  static final FlyingEntityConfig _mageConfig = FlyingEntityConfig(
    entityConfig: _baseEntityConfig,
    idleConfig: AnimationConfig(
      stepTime: 0.1,
      frames: 8,
    ),
    attackRange: () => GlobalVars.rand.nextInt(220) + 300,
  );

  late final RectangleHitbox _hitbox = EntityHelper.createRectangleHitbox(
      size: Vector2(36, 50),
      anchor: Anchor.topCenter,
      position: Vector2(80, 67),
      collisionType: CollisionType.active,
      isSolid: true);

  Mage({super.scaleModifier}) : super(flyingEntityConfig: _mageConfig) {
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

    world.projectileManager.addProjectile(CurvingMagicProjectile(
        initialPosition: attackPosition,
        targetPosition: world.playerBase.wall.absoluteCenter,
        damage: _baseEntityConfig.damageOnAttack));
  }

  static Mage spawn({required double skyHeight}) {
    var scaleModifier = MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.25);
    var mage = Mage(scaleModifier: scaleModifier);

    // Magic ✨
    var startPosition = Vector2(
      -GlobalVars.rand.nextDouble() * mage.scaledSize.x / 2,
      GlobalVars.rand.nextDouble() * (skyHeight / 3) + (skyHeight / 2.5),
    );

    mage.position = startPosition - Vector2(mage.scaledSize.x, mage.scaledSize.y / 2.2);
    return mage;
  }
}
