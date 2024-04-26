import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

mixin DisappearOnDeath on Entity {
  bool _removingAnimation = false;

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
          removeFromParent();
        });
    }

    super.update(dt);
  }
}
