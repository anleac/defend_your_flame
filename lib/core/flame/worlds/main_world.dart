import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/environment/environment.dart';
import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/round_manager.dart';
import 'package:flame/components.dart';

class MainWorld extends World {
  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  late final Environment _environment = Environment();

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 300, worldHeight - 50)
    ..anchor = Anchor.bottomLeft;

  late final RoundManager _roundManager = RoundManager();
  RoundManager get roundManager => _roundManager;
  int get currentRound => _roundManager.currentRound;

  late final EntityManager _entityManager = EntityManager();
  EntityManager get entityManager => _entityManager;
  bool get roundOver => _entityManager.roundOver;

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
    add(_roundManager);
    add(_entityManager);
  }
}
