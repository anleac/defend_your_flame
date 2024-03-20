import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/buildings/castle.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/environment/environment.dart';
import 'package:defend_your_flame/core/flame/managers/effect_manager.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/hud_manager.dart';
import 'package:defend_your_flame/core/flame/managers/round_manager.dart';
import 'package:defend_your_flame/core/flame/managers/world_state_manager.dart';
import 'package:flame/components.dart';

class MainWorld extends World {
  final Environment _environment = Environment();

  late final Castle _castle = Castle()
    ..position = Vector2(worldWidth - 320, worldHeight - 35)
    ..anchor = Anchor.bottomLeft;

  final RoundManager _roundManager = RoundManager();
  final EntityManager _entityManager = EntityManager();
  final EffectManager _effectManager = EffectManager();
  final WorldStateManager _worldStateManager = WorldStateManager();

  Castle get castle => _castle;

  EntityManager get entityManager => _entityManager;
  EffectManager get effectManager => _effectManager;
  RoundManager get roundManager => _roundManager;
  WorldStateManager get worldStateManager => _worldStateManager;

  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  @override
  Future<void> onLoad() async {
    add(_environment);
    add(_castle);
    add(_entityManager);
    add(_effectManager);

    add(CameraBorder());

    // Generally, we should add the HUD to the camera viewpoint to ensure it doesn't move
    // with the world. However, in this case, we have no camera movement and therefore
    // we can add it directly to the world.
    add(HudManager());

    _addNonVisualComponents();

    return super.onLoad();
  }

  _addNonVisualComponents() {
    add(_roundManager);
  }
}
