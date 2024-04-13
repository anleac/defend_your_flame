import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainGame extends FlameGame {
  // Perhaps these won't ever be needed and can be deleted
  double get windowHeight => camera.viewport.size.y;
  double get windowWidth => camera.viewport.size.x;

  // Given this game is within a fixed aspect ratio, this is a simple way to calculate the scaling factor of the games window.
  double get windowScale => windowWidth / Constants.desiredWidth;

  // These are set in `setExternalDependencies`.
  // Is there a better way to do this?
  late AppStrings _appStrings;
  late GameData _gameData;

  AppStrings get appStrings => _appStrings;
  GameData get gameData => _gameData;

  MainGame({required World world, required CameraComponent camera}) : super(world: world, camera: camera);

  @override
  Future<void> onLoad() async {
    await SpriteManager.init();

    /*add(TimestepFaker(
      useFakeTimestep: DebugConstants.useFakeTimestep,
      fakeFps: DebugConstants.fakeFps,
    ));*/

    return super.onLoad();
  }

  @override
  void onRemove() {
    removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
  }

  void setExternalDependencies(BuildContext context) {
    // This is where we would set up any external dependencies that the game needs to know about.
    // Needed for translations and saving data.
    // This _must_ be called prior to the game being started.
    _appStrings = AppStrings.of(context);
    _gameData = GameData.of(context);
  }
}
