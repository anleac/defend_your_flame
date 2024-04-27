// A particle engine that emits basic particles every X ms

import 'dart:ui';

import 'package:defend_your_flame/core/flame/helpers/performance_helper.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/animation.dart';

class TrailingParticles extends PositionComponent with HasWorldReference<MainWorld> {
  final double emissionsPerSecond;
  final double particleLifetime;

  final Color colorFrom;
  final Color colorTo;

  final Tween<double> noise = Tween(begin: -1, end: 1);
  final ColorTween colorTween;

  double timeSinceLastEmission = 0.0;

  TrailingParticles({
    required this.emissionsPerSecond,
    required this.particleLifetime,
    required this.colorFrom,
    required this.colorTo,
  }) : colorTween = ColorTween(begin: colorFrom, end: colorTo);

  ParticleSystemComponent _generateParticlesAtCurrentPosition() {
    return ParticleSystemComponent(
      position: absolutePosition.clone(),
      particle: Particle.generate(
        count: PerformanceHelper.toParticleAmount(4),
        generator: (i) {
          return AcceleratedParticle(
            lifespan: particleLifetime,
            speed: Vector2(
                  noise.transform(GlobalVars.rand.nextDouble()),
                  noise.transform(GlobalVars.rand.nextDouble()),
                ) *
                i.toDouble(),
            child: CircleParticle(
              radius: 1,
              paint: Paint()..color = colorTween.transform(GlobalVars.rand.nextDouble())!,
            ),
          );
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    timeSinceLastEmission += dt;

    if (timeSinceLastEmission >= 1 / emissionsPerSecond) {
      world.effectManager.add(_generateParticlesAtCurrentPosition());
      timeSinceLastEmission = 0.0;
    }
  }
}
