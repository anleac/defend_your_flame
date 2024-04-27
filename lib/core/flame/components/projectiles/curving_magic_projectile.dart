// A class which, fires from a given position, and curves towards a target position with a given speed.
// The curve is bent upwards, as if gravity is pulling it down.
// This represents the base class with the intent to be extended, for either friendly or enemy projectiles.

// Gravity is already represented by PhysicsConstants.gravity (which is a vector2), where the y represents the force of gravity over a second (thus we need to use dt)

import 'dart:async';
import 'dart:math';

import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/effects/particles/trailing_particles.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CurvingMagicProjectile extends PositionComponent {
  final Vector2 initialPosition;
  final Vector2 targetPosition;

  Vector2 _velocity = Vector2.zero();

  final double speed;

  late final TrailingParticles _trailingParticles = TrailingParticles(
    emissionsPerSecond: 50,
    particleLifetime: 0.2,
    colorFrom: Colors.orange,
    colorTo: Colors.red,
  )..position = Vector2.zero();

  CurvingMagicProjectile({
    required this.initialPosition,
    required this.targetPosition,
    this.speed = 200,
  }) {
    position = initialPosition.clone();

    // Calculate the distance to the target
    double distanceX = targetPosition.x - initialPosition.x;
    double distanceY = targetPosition.y - initialPosition.y;

    // Calculate the total distance to the target
    double totalDistance = sqrt(distanceX * distanceX + distanceY * distanceY);

    // Calculate the time it will take to reach the target
    double time = totalDistance / speed;

    // Calculate the initial x and y velocities
    double vx = distanceX / time;
    double vy = (distanceY - 0.5 * PhysicsConstants.magicalGravity.y * time * time) / time;

    _velocity = Vector2(vx, vy);
  }

  @override
  FutureOr<void> onLoad() {
    add(_trailingParticles);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _velocity = PhysicsHelper.applyMagicalGravity(_velocity, dt);
    position = TimestepHelper.addVector2(position, _velocity, dt);
  }
}
