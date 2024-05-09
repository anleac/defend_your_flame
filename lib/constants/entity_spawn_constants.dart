import 'package:defend_your_flame/core/flame/components/entities/mobs/bosses/death_reaper.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/bosses/fire_beast.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';

class EntitySpawnConstants {
  static const int roundToStartSpawningStrongGroundEnemies = 5;
  static const int roundToStartSpawningStrongFlyingEnemies = 8;

  // The minimum amount of weak enemies to ensure are alive during a boss fight.
  static const int minimumToKeepAliveDuringBossFight = 6;

  static const Map<int, List<Type>> bossRounds = {
    10: [FireBeast],
    20: [FireBeast],
    25: [DeathReaper, DeathReaper],
    30: [DeathReaper, FireBeast, DeathReaper],
  };

  static const Set<Type> weakGroundMobs = {Slime, Skeleton};
  static const Set<Type> bossMobs = {DeathReaper, FireBeast};
}
