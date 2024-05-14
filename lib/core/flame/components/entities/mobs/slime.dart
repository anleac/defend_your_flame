import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Slime extends DraggableEntity with DisappearOnDeath {
  static final EntityConfig _slimeConfig = EntityConfig(
    entityResourceName: 'slime',
    defaultSize: Vector2(34, 27),
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 4,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.13,
      frames: 5,
    ),
    dragConfig: AnimationConfig(
      stepTime: 0.1,
      frames: 4,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.07,
      frames: 4,
    ),
    damageOnAttack: 3,
    goldOnKill: 3,
    baseWalkingSpeed: 42,
    defaultScale: 1.15,
  );

  Slime({super.scaleModifier, super.modifiedWalkingSpeed}) : super(entityConfig: _slimeConfig);

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x, scaledSize.y / 2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [
      EntityHelper.createRectangleHitbox(size: Vector2(25, 16), position: Vector2(17, 27), anchor: Anchor.bottomCenter)
    ];
  }

  static Slime spawn({required Vector2 position, required double speedFactor}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final slime =
        Slime(scaleModifier: scaleModifier, modifiedWalkingSpeed: _slimeConfig.baseWalkingSpeed * speedFactor);
    slime.position = position - Vector2(slime.scaledSize.x, -slime.scaledSize.y / 2);
    return slime;
  }
}
