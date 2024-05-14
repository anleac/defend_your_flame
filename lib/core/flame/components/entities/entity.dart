import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_hitbox_positioning.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/mixins/has_wall_collision.dart';
import 'package:defend_your_flame/core/flame/mixins/wall_as_solid.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Entity extends SpriteAnimationGroupComponent<EntityState>
    with
        ParentIsA<EntityManager>,
        HasWorldReference<MainWorld>,
        HasGameReference<MainGame>,
        HasVisibility,
        TapCallbacks,
        HasHitboxPositioning,
        GestureHitboxes,
        CollisionCallbacks,
        HasWallCollision,
        WallAsSolid {
  static const double offscreenTimeoutInSeconds = 3;

  late final List<ShapeHitbox> _hitboxes = addHitboxes();
  late final double _attackOffset = entityConfig.attackRange == null ? 0 : entityConfig.attackRange!() * scale.x;
  late final double _defaultWalkingSpeed;

  final EntityConfig entityConfig;
  final double scaleModifier;

  late double _currentHealth = entityConfig.totalHealth;
  late Vector2 _startingPosition;

  bool _canAttack = false;
  double _offscreenTimerInMilliseconds = 0;

  double get currentHealth => _currentHealth;
  double get totalHealth => entityConfig.totalHealth;
  double get walkingSpeed => _defaultWalkingSpeed;

  Vector2 get startPosition => _startingPosition;
  Vector2 get trueCenter => absoluteCenterOfMainHitbox();

  bool get isWalking => current == EntityState.walking;
  bool get isAlive => _currentHealth > MiscConstants.eps;

  TimeSpendIdle get idleTime => entityConfig.timeSpendIdle;

  Entity({required this.entityConfig, this.scaleModifier = 1, double? modifiedWalkingSpeed}) {
    size = entityConfig.defaultSize;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);
    _defaultWalkingSpeed = modifiedWalkingSpeed ?? entityConfig.baseWalkingSpeed;
  }

  @override
  void onMount() {
    super.onMount();
    _startingPosition = position.clone();
  }

  @override
  Future<void> onLoad() async {
    var speedDifference = _defaultWalkingSpeed / entityConfig.baseWalkingSpeed;
    final walkingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/walk',
        stepTime: entityConfig.walkingConfig.stepTime / scale.x / speedDifference,
        frames: entityConfig.walkingConfig.frames,
        loop: true);

    final attackingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/attack',
        stepTime: entityConfig.attackingConfig.stepTime / scale.x,
        frames: entityConfig.attackingConfig.frames,
        loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/dying',
        stepTime: entityConfig.dyingConfig.stepTime / scale.x, frames: entityConfig.dyingConfig.frames, loop: false);

    if (entityConfig.idleConfig != null) {
      final idleSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/idle',
          stepTime: entityConfig.idleConfig!.stepTime / scale.x, frames: entityConfig.idleConfig!.frames, loop: true);

      animations = {
        ...?animations,
        EntityState.idle: idleSprite,
      };
    }

    animations = {
      ...?animations,
      EntityState.walking: walkingSprite,
      EntityState.attacking: attackingSprite,
      EntityState.dying: dyingSprite,
    };

    current = EntityState.walking;

    addAll(_hitboxes);

    super.onLoad();
  }

  // Intended to be overridden by subclasses
  Vector2? attackEffectPosition() => null;
  List<ShapeHitbox> addHitboxes() => [];

  @override
  void update(double dt) {
    super.update(dt);

    // Special case where the attacking animation is bigger than the default size, maybe we can remove this one day.
    if (current == EntityState.attacking && entityConfig.attackingSize != null) {
      updateSize(entityConfig.attackingSize!, attacking: true);
    } else {
      updateSize(entityConfig.defaultSize, attacking: false);
    }

    _attackingLogic(dt);
    _logicCalculation(dt);
    fallingCalculation(dt);
    _applyBoundingConstraints(dt);
  }

  updateSize(Vector2 newSize, {required bool attacking}) {
    if (size != newSize) {
      size = newSize;
    }
  }

  void _attackingLogic(double dt) {
    if (current == EntityState.attacking) {
      // Special case where the game has ended.
      if (world.worldStateManager.gameOver) {
        current = EntityState.walking;
      } else {
        if (_canAttack && animationTicker?.currentIndex == (entityConfig.attackingConfig.frames / 2).ceil()) {
          _canAttack = false;
          performAttack();
        } else if (animationTicker?.isFirstFrame == true) {
          _canAttack = true;
        }
      }
    }
  }

  performAttack() {
    var damage = (entityConfig.damageOnAttack * scaleModifier).floor();
    world.playerBase.takeDamage(damage, position: attackEffectPosition());
  }

  void _applyBoundingConstraints(double dt) {
    position.y = position.y.clamp(BoundingConstants.minYCoordinate, _startingPosition.y + MiscConstants.eps);
    position.x = position.x.clamp(BoundingConstants.minXCoordinateOffScreen - scaledSize.x,
        world.worldWidth + BoundingConstants.maxXCoordinateOffScreen + (scaledSize.x / 2));

    if (!isAlive || world.worldStateManager.gameOver) {
      return;
    }

    if (current != EntityState.dragged && world.playerBase.entityInside(this)) {
      teleportToStart();
    }

    if (position.x > world.worldWidth) {
      _offscreenTimerInMilliseconds += dt;

      if (position.x > world.worldWidth + BoundingConstants.maxXCoordinateOffScreen &&
          _offscreenTimerInMilliseconds > offscreenTimeoutInSeconds) {
        teleportToStart();
      }
    } else {
      _offscreenTimerInMilliseconds = 0;
    }
  }

  void _logicCalculation(double dt) {
    if (isCollidingWithWall) {
      wallCollisionCalculation(dt);
    } else if (current == EntityState.walking) {
      position.x = TimestepHelper.add(position.x, entityConfig.baseWalkingSpeed * scale.x, dt);

      if (_attackOffset > MiscConstants.eps) {
        final horizontalDistanceToWall = (world.playerBase.position.x - trueCenter.x).abs();
        if (horizontalDistanceToWall <= _attackOffset && world.worldStateManager.playing) {
          current = EntityState.attacking;
        }
      }
    }
  }

  // This should only ever be called when the entity is colliding with a wall.
  void wallCollisionCalculation(double dt) {
    if (current == EntityState.walking) {
      current = EntityState.attacking;
    }
  }

  void fallingCalculation(double dt) {}

  void takeDamage(double damage, {Vector2? position}) {
    _currentHealth -= damage;

    if (_currentHealth <= MiscConstants.eps) {
      initiateDeath();
    } else {
      world.effectManager.addDamageText(damage.toInt(), position ?? trueCenter);
    }
  }

  void initiateDeath() {
    if (current != EntityState.dying) {
      _currentHealth = 0;
      current = EntityState.dying;

      // Apply the bounding constraints to make sure the entity is in the correct position.
      _applyBoundingConstraints(0);
      world.playerBase.mutateGold(entityConfig.goldOnKill, position: trueCenter);

      for (var hitbox in _hitboxes) {
        hitbox.collisionType = CollisionType.inactive;
      }
    }
  }

  void teleportToStart() {
    // If they're dead, theres no real point to do this.
    if (isAlive) {
      position = _startingPosition;
      current = EntityState.walking;
    }
  }
}
