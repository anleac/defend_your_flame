import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class RoundManager extends Component with HasWorldReference<MainWorld> {
  int _currentRound = 0;
  int get currentRound => _currentRound;

  void startNextRound() {
    _currentRound++;
    world.worldStateManager.changeState(MainWorldState.playing);
    world.entityManager.startSpawningRound();
  }

  void restartGame() {
    _currentRound = 0;
    world.playerManager.reset();
    world.entityManager.clearEntities();

    startNextRound();
  }
}
