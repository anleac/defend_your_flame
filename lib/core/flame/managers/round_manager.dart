import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class RoundManager extends Component with ParentIsA<MainWorld> {
  int _currentRound = 0;

  int get currentRound => _currentRound;

  @override
  void update(double dt) {
    super.update(dt);
  }

  void startNextRound() {
    _currentRound++;
  }
}
