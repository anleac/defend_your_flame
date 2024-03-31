import 'package:defend_your_flame/core/flame/components/environment/components/background_scenery.dart';
import 'package:defend_your_flame/core/flame/components/environment/components/ground.dart';
import 'package:defend_your_flame/core/flame/components/environment/components/moon.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Environment extends PositionComponent with ParentIsA<MainWorld> {
  late final BackgroundScenery _backgroundScenery = BackgroundScenery()
    ..position = Vector2(0, parent.worldHeight)
    ..anchor = Anchor.bottomLeft
    ..opacity = 0.35;

  late final Ground _ground = Ground()
    ..position = Vector2(0, parent.worldHeight + 20)
    ..anchor = Anchor.bottomLeft;

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
