import 'package:defend_your_flame/core/flame/components/projectiles/curving_magic_projectile.dart';
import 'package:flutter/material.dart';

class AttackTotemCurvingProjectile extends CurvingMagicProjectile {
  AttackTotemCurvingProjectile(
      {required super.initialPosition,
      required super.targetPosition,
      required super.targetXVelocity,
      required super.damage})
      : super(
            colorFrom: const Color.fromARGB(255, 180, 10, 186),
            colorTo: const Color.fromARGB(255, 94, 0, 110),
            horizontalPixelsPerSecond: 200,
            isFriendly: true,
            strongMagicalGravity: false);
}
