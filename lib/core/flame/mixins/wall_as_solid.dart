import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

mixin WallAsSolid on Entity {
  late final int assignedWallId;
  bool _onTopOfWall = false;

  Rect get wallBox => world.playerBase.wall.solidBoxes[assignedWallId];
  bool get onTopOfWall => _onTopOfWall;

  @override
  void onMount() {
    super.onMount();

    var wallBoxes = world.playerBase.wall.solidBoxes;

    // TODO: This is a very naive way to assign the wall id
    var closestWallBox = wallBoxes.reduce((a, b) {
      var aDistance = a.bottomCenter.dy - trueCenter.y;
      var bDistance = b.bottomCenter.dy - trueCenter.y;
      return aDistance * aDistance < bDistance * bDistance ? a : b;
    });

    assignedWallId = world.playerBase.wall.solidBoxes.indexOf(closestWallBox);
  }

  (Vector2 position, Vector2 velocity) addVelocitySafely(Vector2 position, Vector2 velocity, double dt) {
    var mainHitbox = hitboxes.first;
    var newPosition = TimestepHelper.addVector2(position, velocity, dt);

    if (mainHitbox is! RectangleHitbox ||
        newPosition.x < world.playerBase.wall.absoluteTopLeftPosition.x - 15 ||
        !world.worldStateManager.playing) {
      return (newPosition, velocity);
    }

    var scaledVelocity = TimestepHelper.addVector2(Vector2.zero(), velocity, dt);
    var newHitbox = mainHitbox.toAbsoluteRect().translate(scaledVelocity.x, scaledVelocity.y);

    // Check if the new hitbox would intersect with the wall hitbox
    if (wallBox.overlaps(newHitbox)) {
      if (velocity.y > 0 && newHitbox.bottom > wallBox.top) {
        velocity.y = 0;
        _onTopOfWall = true;
      } else {
        _onTopOfWall = false;
      }

      if (velocity.y < 0 && newHitbox.top < wallBox.bottom) {
        velocity.y = 0;
      }

      if (velocity.x > 0 && newHitbox.right > wallBox.left) {
        velocity.x = 0;
      }

      if (velocity.x < 0 && newHitbox.left < wallBox.right) {
        velocity.x = 0;
      }

      newPosition = TimestepHelper.addVector2(position, velocity, dt);
    }

    return (newPosition, velocity);
  }
}
