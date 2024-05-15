import 'dart:collection';
import 'dart:ui';

import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_spawn_helper.dart';
import 'package:defend_your_flame/core/flame/managers/extensions/entity_manager_extension.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class EntityManager extends Component with HasWorldReference<MainWorld> {
  // Used to keep a weak reference to the entities, based on their Y position, so we can render them in the correct order.
  // Using this datastructure as it supports O(log n) for insertion and deletion, and O(n) for iteration.
  final SplayTreeMap<int, List<Entity>> _entities = SplayTreeMap();

  bool _spawning = false;
  double _secondsToSpawnOver = 0;
  int _totalSpawnCountThisRound = 0;

  List<Entity> _entitiesToSpawn = [];

  double _timeCounter = 0;

  void clearRound() {
    _spawning = false;
    _entitiesToSpawn.clear();
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

    var (entitiesToSpawn, secondsToSpawnOver) = EntitySpawnHelper.entitiesToSpawn(
        worldHeight: world.worldHeight, skyHeight: world.environment.skyHeight, currentRound: currentRound);
    _entitiesToSpawn = entitiesToSpawn;
    _secondsToSpawnOver = secondsToSpawnOver;

    _totalSpawnCountThisRound = _entitiesToSpawn.length;

    _timeCounter = 0;
  }

  @override
  void update(double dt) {
    if (_spawning) {
      _timeCounter += dt;

      if (_entitiesToSpawn.isNotEmpty && _timeCounter >= (_secondsToSpawnOver / _totalSpawnCountThisRound)) {
        _timeCounter = 0;
        // Add the list in reverse order for performance reasons
        _addEntity(_entitiesToSpawn.last);
        _entitiesToSpawn.removeLast();
      } else if (_entitiesToSpawn.isEmpty) {
        _spawning = false;
      }
    } else if (world.worldStateManager.playing) {
      int aliveCount = 0;
      int weakAliveCount = 0;
      bool bossAlive = false;

      (aliveCount, weakAliveCount, bossAlive) = entitiesInGame();

      if (aliveCount == 0 && world.worldStateManager.playing) {
        world.projectileManager.clearAllProjectiles();
        world.worldStateManager.changeState(MainWorldState.betweenRounds);

        if (world.shopManager.blacksmithPurchased) {
          world.playerBase.wall.repairWallFor(world.playerBase.blacksmith.repairPercentage);
        }
      } else if (bossAlive && weakAliveCount < EntitySpawnConstants.minimumToKeepAliveDuringBossFight) {
        var amountNeededToSpawn = EntitySpawnConstants.minimumToKeepAliveDuringBossFight - weakAliveCount;
        // TODO: Re-visit post beta if we need to stagger these s
        var toAdd = EntitySpawnHelper.spawnExtraWeakMobsDuringBossFight(
            worldHeight: world.worldHeight, currentRound: world.roundManager.currentRound, amount: amountNeededToSpawn);
        for (final entity in toAdd) {
          _addEntity(entity);
        }
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

    if (DebugConstants.drawWallCollisionBoxes) {
      for (var entity in children) {
        if (entity is DraggableEntity && entity.current == EntityState.dragged) {
          canvas.drawRect(entity.wallBox, DebugConstants.darkDebugPaint);
        }
      }
    }

    // super.renderTree(canvas);
  }

  // Wrappers so we can track based on the position of the entity, to render them in the correct order
  _addEntity(Entity entity) {
    // We want to sort by the bottom of the entity as this takes into account various anchor points and sizes.
    var key = (entity.topLeftPosition.y + entity.scaledSize.y).toInt();
    // TODO this appears to not be working for strong skeleton
    if (!_entities.containsKey(key)) {
      _entities[key] = [];
    }

    _entities[key]!.add(entity);
    add(entity);
  }

  removeEntity(Entity entity) {
    entity.removeFromParent();

    var key = (entity.topLeftPosition.y + entity.scaledSize.y).toInt();
    if (_entities.containsKey(key) && _entities[key]!.contains(entity)) {
      _entities[key]!.remove(entity);
      if (_entities[key]!.isEmpty) {
        _entities.remove(key);
      }
    }
  }

  Entity? randomVisibleAliveEntity({bool excludeMagicImmune = true}) {
    var aliveEntities = children.whereType<Entity>().where((e) =>
        e.isAlive &&
        (!e.entityConfig.magicImmune || !excludeMagicImmune) &&
        e.absoluteCenter.x > 10 &&
        e.current != EntityState.dragged);

    if (aliveEntities.isEmpty) {
      return null;
    }

    return MiscHelper.randomElement(aliveEntities);
  }

  void clearEntities() {
    for (var entity in children) {
      if (entity is Entity) {
        removeEntity(entity);
      }
    }

    _entities.clear();
    _spawning = false;
    _entitiesToSpawn.clear();
    _timeCounter = 0;
    _secondsToSpawnOver = 0;
  }
}
