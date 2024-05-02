import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/flying_entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_draggable_collisions.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/events.dart';

class FlyingEntity extends Entity with HasDraggableCollisions {
  final FlyingEntityConfig flyingEntityConfig;

  late final double _distanceToWallToAttack = flyingEntityConfig.attackRange();
  late double _nextIdleTime = _calculateNextIdleTime();

  double _idleTimer = 0.0;

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

  void _shiftStateFromIdle({bool shortDuration = false}) {
    if (current == EntityState.idle) {
      current = EntityState.walking;
    } else if (current == EntityState.walking) {
      current = EntityState.idle;
    }

    _idleTimer = 0.0;
    _nextIdleTime = _calculateNextIdleTime();

    if (shortDuration) {
      _nextIdleTime /= 6;
    }
  }

  double _calculateNextIdleTime() {
    return GlobalVars.rand.nextDouble() * 2 + 2; // next idle time in seconds
  }

  @override
  void update(double dt) {
    _idleTimer += dt;
    if (_idleTimer >= _nextIdleTime) {
      _shiftStateFromIdle();
    }

    if (current == EntityState.walking) {
      final horizontalDistanceToWall = (world.playerBase.position.x - position.x).abs();
      if (horizontalDistanceToWall <= _distanceToWallToAttack && world.worldStateManager.playing) {
        current = EntityState.attacking;
      }
    } else if (current == EntityState.attacking && world.worldStateManager.gameOver) {
      current = EntityState.walking;
    }

    if (isCollidingWithDraggableEntity) {
      takeDamage(DamageConstants.collisionDamage);
      draggableEntity!.takeDamage(DamageConstants.collisionDamage);
      clearDraggableEntity(stopEntityDrag: true);
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Inflict damage on tap and make them idle if they were walking.
    takeDamage(DamageConstants.fallDamage / 5);
    _idleTimer = 0.0;

    if (current == EntityState.walking) {
      _shiftStateFromIdle(shortDuration: true);
    }
  }
}
