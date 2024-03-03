import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/slime.dart';
import 'package:defend_your_flame/core/flame/components/entities/mobs/skeleton.dart';
import 'package:defend_your_flame/core/flame/components/environment/environment.dart';
import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/round_manager.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class MainWorld extends World with HasGameReference<MainGame> {
  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  late final Environment _environment = Environment();

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 300, worldHeight - 50)
    ..anchor = Anchor.bottomLeft;

  late final RoundManager _roundManager = RoundManager();
  RoundManager get roundManager => _roundManager;
  int get currentRound => _roundManager.currentRound;

  @override
  Future<void> onLoad() async {
    _loadVisualElements();
    _loadLogicalElements();
    return super.onLoad();
  }

  _loadVisualElements() {
    add(_environment);
    add(_castle);

    add(CameraBorder());

    // Generally, we should add the HUD to the camera viewpoint to ensure it doesn't move
    // with the world. However, in this case, we have no camera movement and therefore
    // we can add it directly to the world.
    add(LevelHud());
  }

  _loadLogicalElements() {
    var mobSpawner = SpawnComponent(
      factory: (int _) => MiscHelper.randomChance(chance: 80)
          ? Skeleton(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.5))
          : Slime(scaleModifier: MiscHelper.randomDouble(minValue: 1, maxValue: 1.3)),
      period: 1.0,
      area: Circle(Vector2(-30, worldHeight - 130), 60),
    );

    add(mobSpawner);
  }
}
