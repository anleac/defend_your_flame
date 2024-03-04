import 'dart:collection';
import 'dart:ui';

import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class EntityManager extends Component with ParentIsA<MainWorld> {
  // Used to keep a weak reference to the entities, based on their Y position, so we can render them in the correct order.
  // Using this datastructure as it supports O(log n) for insertion and deletion, and O(n) for iteration.
  final SplayTreeMap<int, List<WalkingEntity>> _entities = SplayTreeMap();

  bool _spawning = false;
  int _secondsToSpawnOver = 0;
  int _remainingEntitiesToSpawn = 0;

  double _timeCounter = 0;

  bool get roundOver => !_spawning && !children.any((element) => element is WalkingEntity && element.isAlive);

  int get positionXBoundary => parent.castle.position.x.toInt() - 20;

  void clearRound() {
    _spawning = false;
    _remainingEntitiesToSpawn = 0;
    _timeCounter = 0;
    _secondsToSpawnOver = 0;

    _entities.clear();

    for (var element in children) {
      if (element is WalkingEntity) {
        element.removeFromParent();
      }
    }
  }

  void startSpawningRound() {
    clearRound();

    var currentRound = parent.currentRound;

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
    var entity = MiscHelper.randomChance(chance: 80)
        ? Skeleton(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5))
        : Slime(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.3));

    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * 25 - 40,
      parent.worldHeight - GlobalVars.rand.nextDouble() * 120 - 80,
    );

    entity.position = startPosition;
    _addEntity(entity);
  }

  // Wrappers so we can track based on the position of the entity, to render them in the correct order
  _addEntity(WalkingEntity entity) {
    var key = entity.position.y.toInt() + entity.scaledSize.y.toInt();
    if (!_entities.containsKey(key)) {
      _entities[key] = [];
    }

    _entities[key]!.add(entity);
    add(entity);
  }
}
