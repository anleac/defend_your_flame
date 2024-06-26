import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/bosses/death_reaper.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/bosses/fire_beast.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/ice_wolf.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/mage.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/rock_golem.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/strong_skeleton.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
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

  static List<Entity> entitiesToSpawn(
      {required double worldHeight, required double skyHeight, required int currentRound}) {
    var entities = <Entity>[];
    var basicMobsToSpawnThisRound = _basicMobsToSpawnThisRound(currentRound);
    var strongGroundMobsToSpawnThisRound = _strongGroundMobsToSpawnThisRound(currentRound);
    var flyingMobsToSpawnThisRound = _flyingMobsToSpawnThisRound(currentRound);
    var isBossRound = EntitySpawnConstants.bossRounds.containsKey(currentRound);

    if (isBossRound) {
      // If it's a boss round, reduce the number of strong enemies, but increase the number of weaks.
      const reductionFactor = 2.0;
      var beforeReduction = strongGroundMobsToSpawnThisRound + flyingMobsToSpawnThisRound;
      strongGroundMobsToSpawnThisRound = (strongGroundMobsToSpawnThisRound / reductionFactor).ceil();
      flyingMobsToSpawnThisRound = (flyingMobsToSpawnThisRound / reductionFactor).ceil();
      var totalReduction = strongGroundMobsToSpawnThisRound + flyingMobsToSpawnThisRound - beforeReduction;

      basicMobsToSpawnThisRound += totalReduction;
    }

    // Add in the weak mobs
    for (var i = 0; i < basicMobsToSpawnThisRound; i++) {
      entities.add(_spawnBasicGroundMob(worldHeight: worldHeight, currentRound: currentRound));
    }

    // Add in the strong mobs, we currently only have strong skeleton
    for (var i = 0; i < strongGroundMobsToSpawnThisRound; i++) {
      entities.add(_spawnStrongGroundMob(worldHeight: worldHeight, currentRound: currentRound));
    }

    // Add in the flying mobs, we currently only have the mage for flying
    for (var i = 0; i < flyingMobsToSpawnThisRound; i++) {
      entities.add(Mage.spawn(skyHeight: skyHeight));
    }

    // Add in the boss mobs
    for (var bossType in EntitySpawnConstants.bossRounds[currentRound] ?? []) {
      entities.add(_spawnBossMobs(worldHeight: worldHeight, currentRound: currentRound, bossType: bossType));
    }

    entities.shuffle(GlobalVars.rand);

    return entities;
  }

  static List<Entity> spawnExtraWeakMobsDuringBossFight(
      {required double worldHeight, required int currentRound, required int amount}) {
    var entities = <Entity>[];
    for (var i = 0; i < amount; i++) {
      entities.add(_spawnBasicGroundMob(worldHeight: worldHeight, currentRound: currentRound));
    }

    return entities;
  }

  static Entity _spawnBossMobs({required double worldHeight, required int currentRound, required Type bossType}) {
    var startPosition = _randomGroundSpawnPosition(worldHeight: worldHeight);
    if (bossType == DeathReaper) {
      return DeathReaper.spawn(position: startPosition);
    } else if (bossType == FireBeast) {
      return FireBeast.spawn(position: startPosition);
    } else {
      throw Exception('Invalid boss type');
    }
  }

  static Entity _spawnBasicGroundMob({required double worldHeight, required int currentRound}) {
    var startPosition = _randomGroundSpawnPosition(worldHeight: worldHeight);
    var speedFactor = _randomWalkingSpeedFactor(currentRound: currentRound);
    var randomNumber = GlobalVars.rand.nextInt(100);
    var wolfLuck = MiscHelper.tapper(currentRound.toDouble() * 2, tapperLess: true);

    if (currentRound >= EntitySpawnConstants.minimumRoundForFastGroundEnemies && randomNumber < wolfLuck) {
      return IceWolf.spawn(position: startPosition, speedFactor: speedFactor);
    } else if (randomNumber < 70 + (wolfLuck / 2)) {
      return Skeleton.spawn(position: startPosition, speedFactor: speedFactor);
    } else {
      return Slime.spawn(position: startPosition, speedFactor: speedFactor);
    }
  }

  static Entity _spawnStrongGroundMob({required double worldHeight, required int currentRound}) {
    var startPosition = _randomGroundSpawnPosition(worldHeight: worldHeight);
    var speedFactor = _randomWalkingSpeedFactor(currentRound: currentRound);
    var randomNumber = GlobalVars.rand.nextInt(100);

    if (currentRound >= EntitySpawnConstants.minimumRoundForRockGolems &&
        randomNumber < MiscHelper.tapper(currentRound.toDouble() * 3, tapperLess: true)) {
      return RockGolem.spawn(position: startPosition, speedFactor: speedFactor);
    } else {
      return StrongSkeleton.spawn(position: startPosition, speedFactor: speedFactor);
    }
  }

  static int _basicMobsToSpawnThisRound(int currentRound) =>
      MiscHelper.tapper(currentRound * 12, tapperLess: true).ceil() + 2;
  static int _strongGroundMobsToSpawnThisRound(int currentRound) {
    if (currentRound < EntitySpawnConstants.minimumRoundForStrongGroundEnemies) {
      return 0;
    }

    return MiscHelper.tapper((currentRound - EntitySpawnConstants.minimumRoundForStrongGroundEnemies) * 4).ceil();
  }

  static int _flyingMobsToSpawnThisRound(int currentRound) {
    if (currentRound < EntitySpawnConstants.minimumRoundForStrongFlyingEnemies) {
      return 0;
    }

    return MiscHelper.tapper((currentRound - EntitySpawnConstants.minimumRoundForStrongFlyingEnemies) * 2).ceil();
  }

  static Vector2 _randomGroundSpawnPosition({required double worldHeight}) {
    return Vector2(
      GlobalVars.rand.nextDouble() * -25 - 40,
      worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );
  }

  static double _increasedWalkSpeedFactor({required int currentRound}) {
    if (currentRound <= EntitySpawnConstants.roundToStartIncreasingSpeed) {
      return 1;
    }

    var influence = MiscHelper.tapper((currentRound - EntitySpawnConstants.roundToStartIncreasingSpeed) * 3) / 100;
    return 1 + influence;
  }

  static double _randomWalkingSpeedFactor({required int currentRound, bool scaleWithRound = true}) {
    const double speedVariance = 5;
    var roundFactor = scaleWithRound ? _increasedWalkSpeedFactor(currentRound: currentRound) : 1;
    var varianceFactor = (GlobalVars.rand.nextDouble() * (speedVariance * 2) - speedVariance) / 100.0;

    return (1 + varianceFactor) * roundFactor;
  }
}
