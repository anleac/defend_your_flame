import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/components/debug/camera_border.dart';
import 'package:defend_your_flame/core/flame/components/environment/environment.dart';
import 'package:defend_your_flame/core/flame/managers/effect_manager.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/hud_manager.dart';
import 'package:defend_your_flame/core/flame/managers/player_manager.dart';
import 'package:defend_your_flame/core/flame/managers/projectile_manager.dart';
import 'package:defend_your_flame/core/flame/managers/round_manager.dart';
import 'package:defend_your_flame/core/flame/managers/shop_manager.dart';
import 'package:defend_your_flame/core/flame/managers/world_state_manager.dart';
import 'package:flame/components.dart';

class MainWorld extends World with HasCollisionDetection {
  final Environment _environment = Environment();

  final PlayerManager _playerManager = PlayerManager();
  final RoundManager _roundManager = RoundManager();
  final EntityManager _entityManager = EntityManager();
  final ProjectileManager _projectileManager = ProjectileManager();
  final EffectManager _effectManager = EffectManager();
  final WorldStateManager _worldStateManager = WorldStateManager();
  final ShopManager _shopManager = ShopManager();

  Environment get environment => _environment;

  PlayerManager get playerManager => _playerManager;
  EntityManager get entityManager => _entityManager;
  ProjectileManager get projectileManager => _projectileManager;
  EffectManager get effectManager => _effectManager;
  RoundManager get roundManager => _roundManager;
  WorldStateManager get worldStateManager => _worldStateManager;
  ShopManager get shopManager => _shopManager;

  double get worldHeight => Constants.desiredHeight;
  double get worldWidth => Constants.desiredWidth;

  @override
  Future<void> onLoad() async {
    add(_environment);
    add(_playerManager);
    add(_entityManager);
    add(_projectileManager);
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
    add(_shopManager);
  }
}
