import 'package:defend_your_flame/core/flame/components/projectiles/curving_magic_projectile.dart';
import 'package:flutter/material.dart';

class MageCurvingProjectile extends CurvingMagicProjectile {
  MageCurvingProjectile({required super.initialPosition, required super.targetPosition, required super.damage})
      : super(colorFrom: Colors.deepOrange, colorTo: const Color.fromARGB(255, 238, 16, 0));
}
