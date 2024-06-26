import 'package:defend_your_flame/core/flame/components/entities/base_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

mixin DisappearOnDeath on BaseEntity {
  bool _removingAnimation = false;

  // The speed at which the entity will disappear when it dies, higher values will make it disappear faster.
  double _disappearSpeedFactor = 1;

  void setDisappearSpeedFactor(double factor) {
    _disappearSpeedFactor = factor;
  }

  @override
  void update(double dt) {
    if (current == EntityState.dying && !_removingAnimation) {
      _removingAnimation = true;
      add(OpacityEffect.by(
        -0.95,
        EffectController(
          duration: 1.5 / _disappearSpeedFactor,
          curve: Curves.decelerate,
        ),
      )..onComplete = () {
          isVisible = false;
          world.entityManager.removeEntity(this as Entity);
        });
    }

    super.update(dt);
  }
}
