import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:scoped_model/scoped_model.dart';

class GameProvider extends Model {
  static GameProvider of(context) => ScopedModel.of<GameProvider>(context);

  // Apparently the pauseWhenBackgrounded is not working on non-mobile (https://docs.flame-engine.org/latest/flame/game.html)
  late final MainGame _game = MainGame()..pauseWhenBackgrounded = false;
  MainGame get game => _game;
}
