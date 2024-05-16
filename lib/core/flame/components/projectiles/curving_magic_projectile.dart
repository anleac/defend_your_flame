// A class which, fires from a given position, and curves towards a target position with a given speed.
// The curve is bent upwards, as if gravity is pulling it down.
// This represents the base class with the intent to be extended, for either friendly or enemy projectiles.

// Gravity is already represented by PhysicsConstants.gravity (which is a vector2), where the y represents the force of gravity over a second (thus we need to use dt)

import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/effects/particles/trailing_particles.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_entity_collisions.dart';
import 'package:defend_your_flame/core/flame/mixins/has_wall_collision_detection.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CurvingMagicProjectile extends PositionComponent
    with CollisionCallbacks, HasWallCollisionDetection, HasEntityCollisions, HasWorldReference<MainWorld> {
  static const double removalYThreshold = 15;

  final Vector2 initialPosition;
  final Vector2 targetPosition;

  final double targetXVelocity;

  final int damage;
  final bool isFriendly;

  Vector2 _velocity = Vector2.zero();

  final double horizontalPixelsPerSecond;
  final Color colorFrom;
  final Color colorTo;

  late Vector2 _gravityInUse;

  late final TrailingParticles _trailingParticles = TrailingParticles(
    emissionsPerSecond: 50,
    particleLifetime: 0.22,
    colorFrom: colorFrom,
    colorTo: colorTo,
  )..position = Vector2.zero();

  CurvingMagicProjectile({
    required this.initialPosition,
    required this.targetPosition,
    required this.damage,
    required this.colorFrom,
    required this.colorTo,
    this.targetXVelocity = 0,
    this.horizontalPixelsPerSecond = 170,
    this.isFriendly = false,
    bool strongMagicalGravity = false,
  }) {
    position = initialPosition.clone();
    _gravityInUse = strongMagicalGravity ? PhysicsConstants.strongMagicalGravity : PhysicsConstants.magicalGravity;
    _velocity = PhysicsHelper.calculateVelocityToTarget(
      initialPosition: initialPosition,
      targetPosition: targetPosition,
      horizontalPixelsPerSecond: horizontalPixelsPerSecond,
      gravity: _gravityInUse,
      targetXVelocity: targetXVelocity,
    );
  }

  @override
  FutureOr<void> onLoad() {
    add(_trailingParticles);
    add(CircleHitbox(radius: 4));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _velocity = PhysicsHelper.applyCustomGravity(_velocity, _gravityInUse, dt);
    position = TimestepHelper.addVector2(position, _velocity, dt);

    if (!isFriendly && isCollidingWithWall) {
      removeFromParent();
      if (!isFriendly) {
        world.playerBase.takeDamage(damage, position: wallIntersectionPoints.first);
      }
    } else if (isCollidingWithEntity && isFriendly && !collidedEntity!.entityConfig.magicImmune) {
      removeFromParent();
      if (isFriendly) {
        collidedEntity?.takeDamage(damage.toDouble());
      }
    }

    if (position.y > world.worldHeight + BoundingConstants.maxYCoordinateOffScreen) {
      removeFromParent();
    }
  }
}
