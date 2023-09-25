import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/environment/ground.dart';
import 'package:defend_your_flame/core/flame/components/environment/moon.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class MainWorld extends World with HasGameReference<MainGame> {
  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  late final Ground _ground = Ground()
    ..position = Vector2(0, worldHeight)
    ..anchor = Anchor.bottomLeft;

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 300, worldHeight - 40)
    ..anchor = Anchor.bottomLeft;

  @override
  Future<void> onLoad() async {
    add(Moon());
    add(_ground);
    add(_castle);

    add(CameraBorder());

    var skeletonSpawner = SpawnComponent(
      factory: (int _) => Skeleton(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5)),
      period: 1.0,
      area: Circle(Vector2(-30, worldHeight - 110), 35),
    );

    add(skeletonSpawner);

    return super.onLoad();
  }
}
