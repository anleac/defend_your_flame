import 'package:defend_your_flame/core/flame/helpers/round_helper.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

mixin HasWorldStateManager on Component, HasWorldReference<MainWorld> {
  // This may be slightly prone to issues when debugging and manually changing the state, though in a real environment this should always be true
  MainWorldState _worldState = MainWorldState.mainMenu;
  MainWorldState get worldState => _worldState;

  bool get isPlaying => _worldState == MainWorldState.playing;

  @override
  void update(double dt) {
    if (_worldState != world.worldStateManager.currentState) {
      _worldState = world.worldStateManager.currentState;
      onWorldStateChange(_worldState);
    }
    super.update(dt);
  }

  void onWorldStateChange(MainWorldState state) {
    if (state == MainWorldState.playing) {
      int currentRound = world.roundManager.currentRound;
      double approximateSecondsOfRound = RoundHelper.approximateSecondsOfRound(currentRound);
      onRoundStart(currentRound, approximateSecondsOfRound);
    }
  }

  void onRoundStart(int currentRound, double approximateSecondsOfRound);
}
