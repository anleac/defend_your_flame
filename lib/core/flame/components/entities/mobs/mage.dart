import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/flying_entity.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';

class Mage extends FlyingEntity {
  static final EntityConfig _mageConfig = EntityConfig(
    entityResourceName: 'mage',
    defaultSize: Vector2(160, 128),
    attackingCollisionOffset: Vector2(40, 0),
    collisionSize: Vector2(40, 60),
    defaultScale: 1,
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 13,
    ),
    idleConfig: AnimationConfig(
      stepTime: 0.1,
      frames: 8,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.07,
      frames: 8,
    ),
    walkingForwardSpeed: 40,
    damageOnAttack: 0,
    canBePickedUp: false,
  );

  Mage({super.scaleModifier, super.extraXBoundaryOffset}) : super(entityConfig: _mageConfig);

  static Mage spawn({required scaleModifier, required position}) {
    return Mage(scaleModifier: scaleModifier, extraXBoundaryOffset: GlobalVars.rand.nextDouble() * 150 + 150)
      ..position = position - Vector2(_mageConfig.defaultSize.x, 0);
  }
}
