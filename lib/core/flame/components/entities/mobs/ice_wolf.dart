import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class IceWolf extends DraggableEntity with DisappearOnDeath {
  static final EntityConfig _iceWolf = EntityConfig(
    entityResourceName: 'ice_wolf',
    defaultSize: Vector2(64, 48),
    defaultScale: 0.85,
    walkingConfig: AnimationConfig(frames: 8, stepTime: 0.06),
    attackingConfig: AnimationConfig(frames: 14, stepTime: 0.12),
    dragConfig: AnimationConfig(frames: 6, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 6, stepTime: 0.2),
    damageOnAttack: 5,
    goldOnKill: 10,
    baseWalkingSpeed: 96,
  );

  late final RectangleHitbox _hitBox =
      EntityHelper.createRectangleHitbox(size: Vector2(50, 24), position: Vector2(32, 47), anchor: Anchor.bottomCenter);

  IceWolf({super.scaleModifier, super.modifiedWalkingSpeed}) : super(entityConfig: _iceWolf) {
    setDisappearSpeedFactor(1.5);
  }

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x, -scaledSize.y / 2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [_hitBox];
  }

  static IceWolf spawn({required Vector2 position, required double speedFactor}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final iceWolf =
        IceWolf(scaleModifier: scaleModifier, modifiedWalkingSpeed: _iceWolf.baseWalkingSpeed * speedFactor);

    // Since we are using the bottom left anchor, we need to adjust the position.
    iceWolf.position = position - Vector2(iceWolf.scaledSize.x, iceWolf.scaledSize.y / 2);
    return iceWolf;
  }
}
