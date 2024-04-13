import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class Slime extends DraggableEntity {
  static final EntityConfig _slimeConfig = EntityConfig(
    entityResourceName: 'slime',
    defaultSize: Vector2(34, 27),
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 4,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.12,
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
    goldOnKill: 4,
    extraXBoundaryOffset: -10,
    walkingForwardSpeed: 42,
    defaultScale: 1.05,
  );

  bool _removingAnimation = false;

  Slime({super.scaleModifier}) : super(entityConfig: _slimeConfig);

  @override
  void update(double dt) {
    if (!super.isAlive && !_removingAnimation) {
      _removingAnimation = true;
      add(OpacityEffect.by(
        -0.95,
        EffectController(
          duration: 2,
          curve: Curves.decelerate,
        ),
      )..onComplete = () {
          isVisible = false;
        });
    }

    super.update(dt);
  }

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x, scaledSize.y / 2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [
      EntityHelper.createRectangleHitbox(
          size: Vector2(25, 16), position: Vector2(17, 27), anchor: Anchor.bottomCenter, drawDebugBorder: true)
    ];
  }

  static Slime spawn({required position}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final slime = Slime(scaleModifier: scaleModifier);
    slime.position = position - Vector2(slime.scaledSize.x, -slime.scaledSize.y / 2);
    return slime;
  }
}
