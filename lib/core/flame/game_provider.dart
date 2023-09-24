import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:scoped_model/scoped_model.dart';

class GameProvider extends Model {
  static GameProvider of(context) => ScopedModel.of<GameProvider>(context);

  late final MainWorld _mainWorld = MainWorld();

  final FixedAspectRatioViewport _viewportOptions = FixedAspectRatioViewport(aspectRatio: Constants.desireAspectRatio)
    ..anchor = Anchor.topLeft;
  final Viewfinder _viewfinder = Viewfinder()..anchor = Anchor.topLeft;
  late final CameraComponent _cameraComponent =
      CameraComponent(world: _mainWorld, viewport: _viewportOptions, viewfinder: _viewfinder);

  // Apparently the pauseWhenBackgrounded is not working on non-mobile (https://docs.flame-engine.org/latest/flame/game.html)
  late final MainGame _game = MainGame(world: _mainWorld, camera: _cameraComponent)..pauseWhenBackgrounded = false;

  MainGame get game => _game;
}
