import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class DefaultHudBackground extends PositionComponent with HasWorldReference<MainWorld> {
  late final BorderedBackground _background = BorderedBackground()..size = super.size;

  DefaultHudBackground({required MainWorld world}) {
    super.size = Vector2(world.worldWidth / 1.2, world.worldHeight / 1.2);
    super.position = Vector2(world.worldWidth / 2, world.worldHeight / 2);
    super.anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    add(_background);
    return super.onLoad();
  }
}
