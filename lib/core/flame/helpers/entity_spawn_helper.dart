import 'dart:math';

import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/mage.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/strong_skeleton.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class EntitySpawnHelper {
  static double secondsToSpawnOver(int currentRound) {
    return sqrt(currentRound * 10).ceil() + 6;
  }

  static int totalSpawnCountThisRound(int currentRound) {
    // TODO revisit this spawn logic
    return sqrt(currentRound * 15).ceil() + 4;
  }

  static Entity spawnEntity({required double worldHeight, required int currentRound}) {
    var randomNumber = GlobalVars.rand.nextInt(100);

    // TODO add back in mages when you enable a way to kill them.
    if (randomNumber < 95 - (currentRound * 2) && false) {
      return _spawnGroundEntity(worldHeight, currentRound);
      // ignore: dead_code
    } else {
      return _spawnFlyingEntity(worldHeight);
    }
  }

  static Entity _spawnGroundEntity(double worldHeight, int currentRound) {
    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );

    var randomNumber = GlobalVars.rand.nextInt(100);
    if (randomNumber < max(sqrt(currentRound * 5), 25) && currentRound > 2) {
      return StrongSkeleton.spawn(position: startPosition);
    } else if (randomNumber < 70) {
      return Skeleton.spawn(position: startPosition);
    } else {
      return Slime.spawn(position: startPosition);
    }
  }

  static Entity _spawnFlyingEntity(double worldHeight) {
    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      GlobalVars.rand.nextDouble() * worldHeight / 3 + (worldHeight / 6),
    );

    return Mage.spawn(position: startPosition, scaleModifier: MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.25));
  }
}
