import 'dart:collection';
import 'dart:ui';

import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_spawn_helper.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class EntityManager extends Component with HasWorldReference<MainWorld> {
  // Used to keep a weak reference to the entities, based on their Y position, so we can render them in the correct order.
  // Using this datastructure as it supports O(log n) for insertion and deletion, and O(n) for iteration.
  final SplayTreeMap<int, List<Entity>> _entities = SplayTreeMap();

  bool _spawning = false;
  double _secondsToSpawnOver = 0;

  int _totalSpawnCountThisRound = 0;
  int _remainingEntitiesToSpawn = 0;

  double _timeCounter = 0;

  void clearRound() {
    _spawning = false;
    _remainingEntitiesToSpawn = 0;
    _totalSpawnCountThisRound = 0;
    _timeCounter = 0;
    _secondsToSpawnOver = 0;

    _entities.clear();

    for (var element in children) {
      if (element is Entity) {
        element.removeFromParent();
      }
    }
  }

  void startSpawningRound() {
    clearRound();

    var currentRound = world.roundManager.currentRound;

    _spawning = true;

    _totalSpawnCountThisRound = EntitySpawnHelper.totalSpawnCountThisRound(currentRound);
    _remainingEntitiesToSpawn = _totalSpawnCountThisRound;

    _secondsToSpawnOver = EntitySpawnHelper.secondsToSpawnOver(currentRound);

    _timeCounter = 0;
  }

  @override
  void update(double dt) {
    if (_spawning) {
      _timeCounter += dt;

      if (_remainingEntitiesToSpawn > 0 && _timeCounter >= (_secondsToSpawnOver / _totalSpawnCountThisRound)) {
        _timeCounter = 0;

        _remainingEntitiesToSpawn--;
        _addEntity(EntitySpawnHelper.spawnEntity(
            worldHeight: world.worldHeight,
            skyHeight: world.environment.skyHeight,
            currentRound: world.roundManager.currentRound));
      } else if (_remainingEntitiesToSpawn == 0) {
        _spawning = false;
      }
    } else if (world.worldStateManager.playing) {
      // We are no longer spawning, so we can check if any entities are still alive.
      var anyEntitiesAlive = children.any((element) => element is Entity && element.isAlive);

      if (!anyEntitiesAlive) {
        world.projectileManager.clearAllProjectiles();
        world.worldStateManager.changeState(MainWorldState.betweenRounds);
      }
    }

    super.update(dt);
  }

  @override
  void renderTree(Canvas canvas) {
    // Explicitly _not_ calling super, as we want to render the entities in the correct order
    // Iterating over the splay map will give us the entities in the correct order, ordered in ascending Y position
    for (var entitiesAtYPosition in _entities.values) {
      for (var entity in entitiesAtYPosition) {
        entity.renderTree(canvas);
      }
    }

    // super.renderTree(canvas);
  }

  // Wrappers so we can track based on the position of the entity, to render them in the correct order
  _addEntity(Entity entity) {
    // We want to sort by the bottom of the entity as this takes into account various anchor points and sizes.
    var key = (entity.topLeftPosition.y + entity.scaledSize.y).toInt();

    if (!_entities.containsKey(key)) {
      _entities[key] = [];
    }

    _entities[key]!.add(entity);
    add(entity);
  }

  void clearEntities() {
    for (var entity in children) {
      if (entity is Entity) {
        entity.removeFromParent();
      }
    }
  }
}
