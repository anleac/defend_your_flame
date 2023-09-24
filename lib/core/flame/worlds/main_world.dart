import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/environment/ground.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class MainWorld extends World with HasGameReference<MainGame> {
  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  late final Ground _ground = Ground()
    ..position = Vector2(0, worldHeight)
    ..anchor = Anchor.bottomLeft;

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 300, worldHeight - 60)
    ..anchor = Anchor.bottomLeft;

  @override
  Future<void> onLoad() async {
    add(_ground);
    add(_castle);
    add(CameraBorder());

    return super.onLoad();
  }
}
