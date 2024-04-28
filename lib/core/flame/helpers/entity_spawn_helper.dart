import 'dart:math';

import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/mage.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/strong_skeleton.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';

class EntitySpawnHelper {
  static double secondsToSpawnOver(int currentRound) {
    return sqrt(currentRound * 10).ceil() + 6;
  }

  static int totalSpawnCountThisRound(int currentRound) {
    // TODO revisit this spawn logic
    return sqrt(currentRound * 15).ceil() + 4;
  }

  static Entity spawnEntity({required double worldHeight, required double skyHeight, required int currentRound}) {
    var randomNumber = GlobalVars.rand.nextInt(100);

    if (randomNumber < 95 - (currentRound * 1.5) || currentRound <= 3) {
      return _spawnGroundEntity(worldHeight: worldHeight, currentRound: currentRound);
      // ignore: dead_code
    } else {
      return _spawnFlyingEntity(skyHeight: skyHeight);
    }
  }

  static Entity _spawnGroundEntity({required double worldHeight, required int currentRound}) {
    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );

    var randomNumber = GlobalVars.rand.nextInt(100);
    if (randomNumber < max(sqrt(currentRound * 4), 25) && currentRound > 2) {
      return StrongSkeleton.spawn(position: startPosition);
    } else if (randomNumber < 70) {
      return Skeleton.spawn(position: startPosition);
    } else {
      return Slime.spawn(position: startPosition);
    }
  }

  static Entity _spawnFlyingEntity({required double skyHeight}) {
    return Mage.spawn(skyHeight: skyHeight);
  }
}
