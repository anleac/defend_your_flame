import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
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
    var targetArea = absoluteBottomOfMainHitbox();
    // TODO: This is a very naive way to assign the wall id
    var closestWallBox = wallBoxes.reduce((a, b) {
      var aDistance = a.bottomCenter.dy - targetArea.y;
      var bDistance = b.bottomCenter.dy - targetArea.y;
      return aDistance * aDistance < bDistance * bDistance ? a : b;
    });

    assignedWallId = world.playerBase.wall.solidBoxes.indexOf(closestWallBox);
  }

  @override
  void update(double dt) {
    if (world.worldStateManager.gameOver && _onTopOfWall) {
      _onTopOfWall = false;

      if (current == EntityState.attacking || current == EntityState.walking) {
        current = EntityState.falling;
      }
    }

    super.update(dt);
  }

  (Vector2 position, Vector2 velocity) addVelocitySafely(Vector2 position, Vector2 velocity, double dt) {
    var mainHitbox = hitboxes.first;
    var newPosition = TimestepHelper.addVector2(position, velocity, dt);
    var tmpVelocity = velocity.clone();

    if (mainHitbox is! RectangleHitbox || (trueCenter.x < world.worldWidth / 2) || !world.worldStateManager.playing) {
      _onTopOfWall = false;
      return (newPosition, velocity);
    }

    var scaledVelocity = TimestepHelper.addVector2(Vector2.zero(), velocity, dt);
    var newHitbox = mainHitbox.toAbsoluteRect().translate(scaledVelocity.x, scaledVelocity.y);

    // Check if the new hitbox would intersect with the wall hitbox
    if (newHitbox.overlaps(wallBox)) {
      if (tmpVelocity.y > 0 && MiscHelper.doubleGreaterThanOrEquals(newHitbox.bottom, wallBox.top)) {
        tmpVelocity.y = 0;
        _onTopOfWall = true;
      } else {
        _onTopOfWall = false;
      }

      if (tmpVelocity.y < 0 && MiscHelper.doubleGreaterThanOrEquals(wallBox.bottom, newHitbox.top)) {
        tmpVelocity.y = 0;
      }

      if (tmpVelocity.x < 0 && MiscHelper.doubleGreaterThanOrEquals(wallBox.right, newHitbox.left)) {
        tmpVelocity.x = 0;
      }

      if (tmpVelocity.x > 0 && MiscHelper.doubleGreaterThanOrEquals(newHitbox.right, wallBox.left)) {
        tmpVelocity.x = 0;
      }

      wallCollision(dt);

      newPosition = TimestepHelper.addVector2(position, tmpVelocity, dt);
    } else {
      _onTopOfWall = false;
    }

    return (newPosition, tmpVelocity);
  }
}
