import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/timestep/debug/timestep_faker.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class MainGame extends FlameGame {
  // Perhaps these won't ever be needed and can be deleted
  double get windowHeight => camera.viewport.size.y;
  double get windowWidth => camera.viewport.size.x;

  // Given this game is within a fixed aspect ratio, this is a simple way to calculate the scaling factor of the games window.
  double get windowScale => windowWidth / Constants.desiredWidth;

  MainGame({required World world, required CameraComponent camera}) : super(world: world, camera: camera);

  @override
  Future<void> onLoad() async {
    await SpriteManager.init();

    add(TimestepFaker(
      useFakeTimestep: true,
      fakeFps: 20,
    ));

    return super.onLoad();
  }

  @override
  void onRemove() {
    removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
  }
}
