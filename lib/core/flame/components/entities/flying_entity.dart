import 'package:defend_your_flame/core/flame/components/entities/configs/flying_entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';

class FlyingEntity extends Entity {
  final FlyingEntityConfig flyingEntityConfig;

  late final double _distanceToWallToAttack = flyingEntityConfig.attackRange();

  double _idleTimer = 0.0;
  double _nextIdleTime = 0.0;

  FlyingEntity({required this.flyingEntityConfig, super.scaleModifier})
      : super(entityConfig: flyingEntityConfig.entityConfig);

  @override
  Future<void> onLoad() async {
    assert(flyingEntityConfig.idleConfig != null,
        'Idle config must be set for a flying entity: ${entityConfig.entityResourceName}');

    final idleSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/idle',
        stepTime: flyingEntityConfig.idleConfig!.stepTime / scale.x,
        frames: flyingEntityConfig.idleConfig!.frames,
        loop: true);

    animations = {
      EntityState.idle: idleSprite,
    };

    super.onLoad();
  }

  void _shiftStateFromIdle() {
    if (current == EntityState.idle) {
      current = EntityState.walking;
    } else {
      current = EntityState.idle;
    }

    _idleTimer = 0.0;
    _nextIdleTime = GlobalVars.rand.nextDouble() * 5 + 5; // next idle time in seconds

    if (current == EntityState.idle) {
      // Make idle time much less.
      _nextIdleTime /= 3;
    }
  }

  @override
  void update(double dt) {
    _idleTimer += dt;
    if (_idleTimer >= _nextIdleTime) {
      _shiftStateFromIdle();
    }

    if (current == EntityState.walking) {
      final horizontalDistanceToWall = (world.playerManager.playerBase.position.x - position.x).abs();
      if (horizontalDistanceToWall <= _distanceToWallToAttack) {
        current = EntityState.attacking;
      }
    }

    super.update(dt);
  }
}
