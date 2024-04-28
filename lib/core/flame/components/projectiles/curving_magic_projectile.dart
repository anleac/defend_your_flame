// A class which, fires from a given position, and curves towards a target position with a given speed.
// The curve is bent upwards, as if gravity is pulling it down.
// This represents the base class with the intent to be extended, for either friendly or enemy projectiles.

// Gravity is already represented by PhysicsConstants.gravity (which is a vector2), where the y represents the force of gravity over a second (thus we need to use dt)

import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/effects/particles/trailing_particles.dart';
import 'package:defend_your_flame/core/flame/mixins/has_wall_collision.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CurvingMagicProjectile extends PositionComponent
    with CollisionCallbacks, HasWallCollision, HasWorldReference<MainWorld> {
  final Vector2 initialPosition;
  final Vector2 targetPosition;

  final int damage;

  Vector2 _velocity = Vector2.zero();

  final double horizontalPixelsPerSecond;

  late final TrailingParticles _trailingParticles = TrailingParticles(
    emissionsPerSecond: 50,
    particleLifetime: 0.22,
    colorFrom: Colors.deepOrange,
    colorTo: const Color.fromARGB(255, 238, 16, 0),
  )..position = Vector2.zero();

  CurvingMagicProjectile({
    required this.initialPosition,
    required this.targetPosition,
    required this.damage,
    this.horizontalPixelsPerSecond = 170,
  }) {
    position = initialPosition.clone();
    _velocity = PhysicsHelper.calculateVelocityToTarget(
      initialPosition: initialPosition,
      targetPosition: targetPosition,
      horizontalPixelsPerSecond: horizontalPixelsPerSecond,
      gravity: PhysicsConstants.magicalGravity,
    );
  }

  @override
  FutureOr<void> onLoad() {
    add(_trailingParticles);
    add(CircleHitbox(radius: 2));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _velocity = PhysicsHelper.applyMagicalGravity(_velocity, dt);
    position = TimestepHelper.addVector2(position, _velocity, dt);

    if (isCollidingWithWall) {
      removeFromParent();
      world.playerManager.playerBase.takeDamage(damage, position: wallIntersectionPoints.first);
    }

    if (position.y > world.worldHeight + BoundingConstants.maxYCoordinateOffScreen) {
      removeFromParent();
    }
  }
}
