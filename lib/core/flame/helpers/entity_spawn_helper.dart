import 'dart:math';

import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/mage.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/strong_skeleton.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';

class EntitySpawnHelper {
  // I think we want to do an algorithm that approximately goes like:
  // Assuming we're not in any form of "special round" (like a boss round or blood moon or something)
  // We want to spawn a certain amount of entities over a certain amount of time.
  // We will break up the entities into the following categories:
  // - Basic mobs (slime, skeleton), currently these are all on ground
  // - Flying mobs (mage), these will fly over the ground mobs
  // - Strong mobs (strong skeleton), these will be mixed in with the basic mobs
  // Each round will need to have a certain amount of each category to keep the difficulty somewhat consistent on each play thru.
  // Though within each group, we can have a random amount of each type of mob. (Perhaps we can revisit this later if this goes poorly for consistent difficulty)

  static (List<Entity> toSpawn, double secondsToSpawnOver) entitiesToSpawn(
      {required double worldHeight, required double skyHeight, required int currentRound}) {
    var entities = <Entity>[];
    var secondsToSpawn = _secondsToSpawnOver(currentRound);
    var basicMobsToSpawnThisRound = _basicMobsToSpawnThisRound(currentRound);
    var strongGroundMobsToSpawnThisRound = _strongGroundMobsToSpawnThisRound(currentRound);
    var flyingMobsToSpawnThisRound = _flyingMobsToSpawnThisRound(currentRound);

    // Add in the weak mobs
    for (var i = 0; i < basicMobsToSpawnThisRound; i++) {
      entities.add(_spawnBasicGroundMob(worldHeight: worldHeight, currentRound: currentRound));
    }

    // Add in the strong mobs
    for (var i = 0; i < strongGroundMobsToSpawnThisRound; i++) {
      // Currently we only have the strong skeleton for the ground
      entities.add(StrongSkeleton.spawn(position: _randomGroundSpawnPosition(worldHeight: worldHeight)));
    }

    // Add in the flying mobs
    for (var i = 0; i < flyingMobsToSpawnThisRound; i++) {
      // Currently we only have the mage for flying
      entities.add(Mage.spawn(skyHeight: skyHeight));
    }

    entities.shuffle(GlobalVars.rand);

    return (entities, secondsToSpawn);
  }

  static Entity _spawnBasicGroundMob({required double worldHeight, required int currentRound}) {
    var startPosition = _randomGroundSpawnPosition(worldHeight: worldHeight);

    var randomNumber = GlobalVars.rand.nextInt(100);
    if (randomNumber < 70) {
      return Skeleton.spawn(position: startPosition);
    } else {
      return Slime.spawn(position: startPosition);
    }
  }

  static double _tapper(double input) {
    const double tapper = 0.6;
    // This is a tapper function that will make the spawn rate increase slower as the rounds progress
    // I tried sqrt but it was a bit too high of tappering
    return pow(input, tapper).toDouble();
  }

  static double _secondsToSpawnOver(int currentRound) {
    return _tapper(currentRound * 12).ceil() + 5;
  }

  static int _basicMobsToSpawnThisRound(int currentRound) => _tapper(currentRound * 12).ceil() + 3;
  static int _strongGroundMobsToSpawnThisRound(int currentRound) {
    if (currentRound < EntitySpawnConstants.roundToStartSpawningStrongGroundEnemies) {
      return 0;
    }

    return _tapper((currentRound - EntitySpawnConstants.roundToStartSpawningStrongGroundEnemies) * 5).ceil();
  }

  static int _flyingMobsToSpawnThisRound(int currentRound) {
    if (currentRound < EntitySpawnConstants.roundToStartSpawningStrongFlyingEnemies) {
      return 0;
    }

    return _tapper((currentRound - EntitySpawnConstants.roundToStartSpawningStrongFlyingEnemies) * 3).ceil();
  }

  static Vector2 _randomGroundSpawnPosition({required double worldHeight}) {
    return Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );
  }
}
