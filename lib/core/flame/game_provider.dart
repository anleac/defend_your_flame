import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:scoped_model/scoped_model.dart';

class GameProvider extends Model {
  static GameProvider of(context) => ScopedModel.of<GameProvider>(context);

  late final MainWorld _mainWorld = MainWorld();

  final Viewfinder _viewfinder = Viewfinder()
    ..anchor = Anchor.topLeft
    ..visibleGameSize = Vector2(Constants.desiredWidth, Constants.desiredHeight);

  late final CameraComponent _cameraComponent = CameraComponent.withFixedResolution(
      width: Constants.desiredWidth, height: Constants.desiredHeight, viewfinder: _viewfinder, world: _mainWorld);

  // Apparently the pauseWhenBackgrounded is not working on non-mobile (https://docs.flame-engine.org/latest/flame/game.html)
  late final MainGame _game = MainGame(world: _mainWorld, camera: _cameraComponent)..pauseWhenBackgrounded = false;

  MainGame get game => _game;
}
