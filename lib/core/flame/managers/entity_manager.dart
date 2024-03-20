import 'dart:collection';
import 'dart:ui';

import 'package:defend_your_flame/core/flame/components/entities/mobs/mage.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class EntityManager extends Component with ParentIsA<MainWorld> {
  // Used to keep a weak reference to the entities, based on their Y position, so we can render them in the correct order.
  // Using this datastructure as it supports O(log n) for insertion and deletion, and O(n) for iteration.
  final SplayTreeMap<int, List<Entity>> _entities = SplayTreeMap();

  bool _spawning = false;
  int _secondsToSpawnOver = 0;
  int _remainingEntitiesToSpawn = 0;

  double _timeCounter = 0;

  bool get gameOver => parent.worldStateManager.gameOver;

  int get positionXBoundary => !parent.worldStateManager.gameOver ? parent.castle.position.x.toInt() - 20 : 100000;

  void clearRound() {
    _spawning = false;
    _remainingEntitiesToSpawn = 0;
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

    var currentRound = parent.roundManager.currentRound;

    _spawning = true;

    // Update the logic for how many creatures spawn
    _remainingEntitiesToSpawn = currentRound * 5 + 10;

    // Scale the time duration that they should spawn over
    _secondsToSpawnOver = currentRound + 3;

    _timeCounter = 0;
  }

  @override
  void update(double dt) {
    if (_spawning) {
      _timeCounter += dt;

      if (_remainingEntitiesToSpawn > 0 && _timeCounter >= (_secondsToSpawnOver / _remainingEntitiesToSpawn)) {
        _timeCounter = 0;

        _remainingEntitiesToSpawn--;
        spawnEntity();
      } else if (_remainingEntitiesToSpawn == 0) {
        _spawning = false;
      }
    } else if (parent.worldStateManager.playing) {
      // We are no longer spawning, so we can check if any entities are still alive.
      var anyEntitiesAlive = children.any((element) => element is Entity && element.isAlive);

      if (!anyEntitiesAlive) {
        parent.worldStateManager.changeState(MainWorldState.betweenRounds);
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

  void spawnEntity() {
    var randomNumber = GlobalVars.rand.nextInt(100);

    // TODO add back in mages when you enable a way to kill them.
    if (randomNumber < 95 - (parent.roundManager.currentRound * 2) || true) {
      spawnGroundEntity();
    } else {
      spawnFlyingEntity();
    }
  }

  void spawnFlyingEntity() {
    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      GlobalVars.rand.nextDouble() * parent.worldHeight / 3 + (parent.worldHeight / 6),
    );

    _addEntity(
        Mage.spawn(position: startPosition, scaleModifier: MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.25)));
  }

  void spawnGroundEntity() {
    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      parent.worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );

    var randomNumber = GlobalVars.rand.nextInt(100);
    if (randomNumber < 70) {
      _addEntity(
          Skeleton.spawn(position: startPosition, scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5)));
    } else {
      _addEntity(
          Slime.spawn(position: startPosition, scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.3)));
    }
  }

  // Wrappers so we can track based on the position of the entity, to render them in the correct order
  _addEntity(Entity entity) {
    var key = entity.position.y.toInt();
    if (entity is Skeleton == false) {
      // Skeletons are unique in that I've anchored it bottom left, therefore we don't need to add the scaled Y.
      key += entity.scaledSize.y.toInt();
    }

    if (!_entities.containsKey(key)) {
      _entities[key] = [];
    }

    _entities[key]!.add(entity);
    add(entity);
  }

  void attackCastle(int damageOnAttack) => parent.castle.takeDamage(damageOnAttack);
}
