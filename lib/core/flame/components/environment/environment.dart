import 'package:defend_your_flame/core/flame/components/environment/components/background_scenery.dart';
import 'package:defend_your_flame/core/flame/components/environment/components/ground.dart';
import 'package:defend_your_flame/core/flame/components/environment/components/moon.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Environment extends PositionComponent with HasWorldReference<MainWorld> {
  late final BackgroundScenery _backgroundScenery = BackgroundScenery()
    ..position = Vector2(0, world.worldHeight + 30)
    ..anchor = Anchor.bottomLeft
    ..opacity = 0.4;

  late final Ground _ground = Ground()
    ..position = Vector2(0, world.worldHeight)
    ..anchor = Anchor.bottomLeft;

  // The height of the sky, where the ground starts.
  late final double _skyHeight = _ground.topLeftPosition.y;
  double get skyHeight => _skyHeight;

  Environment() {
    position = Vector2(0, 0);
  }

  @override
  Future<void> onLoad() async {
    add(_backgroundScenery);
    add(_ground);
    add(Moon());

    return super.onLoad();
  }
}
