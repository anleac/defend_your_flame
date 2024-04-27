import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/flying_entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/flying_entity.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Mage extends FlyingEntity {
  static final EntityConfig _baseEntityConfig = EntityConfig(
    entityResourceName: 'mage',
    defaultSize: Vector2(160, 128),
    defaultScale: 1.1,
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 13,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.07,
      frames: 8,
    ),
    walkingForwardSpeed: 40,
    damageOnAttack: 0,
    goldOnKill: 15,
    totalHealth: DamageConstants.fallDamage * 4,
  );

  static final FlyingEntityConfig _mageConfig = FlyingEntityConfig(
    entityConfig: _baseEntityConfig,
    idleConfig: AnimationConfig(
      stepTime: 0.1,
      frames: 8,
    ),
    attackRange: () => GlobalVars.rand.nextInt(150) + 200,
  );

  late final RectangleHitbox _hitbox =
      EntityHelper.createRectangleHitbox(size: Vector2(36, 50), anchor: Anchor.topCenter, position: Vector2(80, 67));

  Mage({super.scaleModifier}) : super(flyingEntityConfig: _mageConfig);

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

  static Mage spawn({required scaleModifier, required position}) {
    var mage = Mage(scaleModifier: scaleModifier);
    mage.position = position - Vector2(mage.scaledSize.x, mage.scaledSize.y / 2);
    return mage;
  }
}
