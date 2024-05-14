import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Rat extends DraggableEntity with DisappearOnDeath {
  static final EntityConfig _ratConfig = EntityConfig(
    entityResourceName: 'rat',
    defaultSize: Vector2(32, 32),
    defaultScale: 2,
    walkingConfig: AnimationConfig(frames: 6, stepTime: 0.12),
    attackingConfig: AnimationConfig(frames: 6, stepTime: 0.2),
    dragConfig: AnimationConfig(frames: 6, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 6, stepTime: 0.12),
    damageOnAttack: 5,
    goldOnKill: 5,
    baseWalkingSpeed: 42,
  );

  late final RectangleHitbox _hitBox =
      EntityHelper.createRectangleHitbox(size: Vector2(20, 15), position: Vector2(8, 16), anchor: Anchor.bottomCenter);

  Rat({super.scaleModifier, super.modifiedWalkingSpeed}) : super(entityConfig: _ratConfig) {
    setDisappearSpeedFactor(1.5);
  }

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x - 15, -scaledSize.y / 2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [_hitBox];
  }

  static Rat spawn({required Vector2 position, required double speedFactor}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final rat = Rat(scaleModifier: scaleModifier, modifiedWalkingSpeed: _ratConfig.baseWalkingSpeed * speedFactor);

    // Since we are using the bottom left anchor, we need to adjust the position.
    rat.position = position + Vector2(-rat.scaledSize.x, rat.scaledSize.y);
    return rat;
  }
}
