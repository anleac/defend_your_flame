import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';

extension EntityManagerExtension on EntityManager {
  (int amountAlive, int weakAmountAlive, bool anyBossAlive) entitiesInGame() {
    int amountAlive = 0;
    int weakAmountAlive = 0;
    bool anyBossAlive = false;

    for (final entity in children) {
      if (entity is Entity) {
        if (!entity.isAlive) {
          continue;
        }

        amountAlive++;
        if (EntitySpawnConstants.weakGroundMobs.contains(entity.runtimeType)) {
          weakAmountAlive++;
        }

        if (EntitySpawnConstants.bossMobs.contains(entity.runtimeType)) {
          anyBossAlive = true;
        }
      }
    }

    return (amountAlive, weakAmountAlive, anyBossAlive);
  }
}
