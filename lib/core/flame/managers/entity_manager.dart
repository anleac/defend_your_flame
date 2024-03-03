import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

class EntityManager extends Component with ParentIsA<MainWorld> {
  bool _spawning = false;
  int _secondsToSpawnOver = 0;
  int _remainingEntitiesToSpawn = 0;

  double _timeCounter = 0;

  bool get roundOver => !_spawning && children.isEmpty;

  void startSpawningRound() {
    var currentRound = parent.currentRound;

    _spawning = true;

    // Update the logic for how many creatures spawn
    _remainingEntitiesToSpawn = currentRound * 5 + 10;

    // Scale the time duration that they should spawn over
    _secondsToSpawnOver = (currentRound * 1.5).toInt();

    _timeCounter = 0;
  }

  @override
  void update(double dt) {
    if (_spawning) {
      _timeCounter += dt;

      if (_timeCounter >= (_secondsToSpawnOver / _remainingEntitiesToSpawn)) {
        _timeCounter = 0;

        if (_remainingEntitiesToSpawn > 0) {
          _remainingEntitiesToSpawn--;
          spawnEntity();
        } else {
          _spawning = false;
        }
      }
    }

    super.update(dt);
  }

  void spawnEntity() {
    var entity = MiscHelper.randomChance(chance: 80)
        ? Skeleton(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5))
        : Slime(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.3));

    var startPosition = Vector2(
      GlobalVars.rand.nextDouble() * (parent.worldWidth - 60),
      GlobalVars.rand.nextDouble() * (parent.worldHeight - 60),
    );

    entity.position = startPosition;
    add(entity);
  }
}
