// This has _no_ update or render logic, and therefore does not need to be added to the component tree.
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';

class WorldStateManager {
  MainWorldState _currentState = DebugConstants.testShopLogic ? MainWorldState.betweenRounds : MainWorldState.mainMenu;
  MainWorldState get currentState => _currentState;

  bool get mainMenu => _currentState == MainWorldState.mainMenu;
  bool get playing => _currentState == MainWorldState.playing;
  bool get betweenRounds => _currentState == MainWorldState.betweenRounds;
  bool get gameOver => _currentState == MainWorldState.gameOver;

  void changeState(MainWorldState newState) {
    if (_currentState != newState) {
      _currentState = newState;
    }
  }
}
