import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class MainGame extends FlameGame {
  // Because in this game - the camera is not moving, we can use the world height and width as the window height and width
  double get windowHeight => camera.viewport.size.y;
  double get windowWidth => camera.viewport.size.x;

  MainGame({required World world, required CameraComponent camera}) : super(world: world, camera: camera);

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    await SpriteManager.init();
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
