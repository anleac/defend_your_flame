import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/environment/background_scenery.dart';
import 'package:defend_your_flame/core/flame/components/environment/ground.dart';
import 'package:defend_your_flame/core/flame/components/environment/moon.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/hud/version_text.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class MainWorld extends World with HasGameReference<MainGame> {
  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  late final BackgroundScenery _backgroundScenery = BackgroundScenery()
    ..position = Vector2(0, worldHeight)
    ..anchor = Anchor.bottomLeft
    ..opacity = 0.35;

  late final Ground _ground = Ground()
    ..position = Vector2(0, worldHeight)
    ..anchor = Anchor.bottomLeft;

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 300, worldHeight - 50)
    ..anchor = Anchor.bottomLeft;

  late final VersionText _versionText = VersionText()
    ..position = Vector2(worldWidth - 10, 10)
    ..anchor = Anchor.topRight;

  late final FpsTextComponent _fpsText = FpsTextComponent()
    ..position = Vector2(worldWidth - 10, _versionText.y + 20)
    ..anchor = Anchor.topRight
    ..scale = _versionText.scale;

  @override
  Future<void> onLoad() async {
    add(Moon());
    add(_backgroundScenery);
    add(_ground);
    add(_castle);

    add(CameraBorder());

    var mobSpawner = SpawnComponent(
      factory: (int _) => MiscHelper.randomChance(chance: 80)
          ? Skeleton(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5))
          : Slime(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.3)),
      period: 1.0,
      area: Circle(Vector2(-30, worldHeight - 130), 60),
    );

    add(mobSpawner);

    // Add directly to the viewport to be an "HUD" component.
    game.camera.viewport.add(_versionText);
    game.camera.viewport.add(_fpsText);

    return super.onLoad();
  }
}
