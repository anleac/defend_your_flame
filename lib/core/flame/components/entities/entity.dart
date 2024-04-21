import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/mixins/has_wall_collision.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Entity extends SpriteAnimationGroupComponent<EntityState>
    with
        ParentIsA<EntityManager>,
        HasWorldReference<MainWorld>,
        HasGameReference<MainGame>,
        HasVisibility,
        CollisionCallbacks,
        HasWallCollision {
  static const double offscreenTimeoutInSeconds = 3;

  final EntityConfig entityConfig;
  final double scaleModifier;

  late double _currentHealth = entityConfig.totalHealth;

  late final List<ShapeHitbox> _hitboxes = addHitboxes();

  late Vector2 _startingPosition;

  Vector2 _lastValidPosition = Vector2.zero();

  bool _canInflictDamage = false;
  double _offscreenTimerInMilliseconds = 0;

  bool get isAlive => _currentHealth > MiscConstants.eps;

  double get currentHealth => _currentHealth;
  double get totalHealth => entityConfig.totalHealth;

  Vector2 get lastPosition => _lastValidPosition;

  Entity({required this.entityConfig, this.scaleModifier = 1}) {
    size = entityConfig.defaultSize;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);
  }

  @override
  void onMount() {
    super.onMount();
    _startingPosition = position.clone();
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/walk',
        stepTime: entityConfig.walkingConfig.stepTime / scale.x, frames: entityConfig.walkingConfig.frames, loop: true);

    final attackingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/attack',
        stepTime: entityConfig.attackingConfig.stepTime / scale.x,
        frames: entityConfig.attackingConfig.frames,
        loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/dying',
        stepTime: entityConfig.dyingConfig.stepTime / scale.x, frames: entityConfig.dyingConfig.frames, loop: false);

    animations = {
      ...?animations,
      EntityState.walking: walkingSprite,
      EntityState.attacking: attackingSprite,
      EntityState.dying: dyingSprite,
    };

    current = EntityState.walking;

    addAll(_hitboxes);
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

    if (!isCollidingWithWall) {
      _lastValidPosition = position.clone();
    }
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
        if (_canInflictDamage && animationTicker?.currentIndex == (entityConfig.attackingConfig.frames / 2).ceil()) {
          // Inflict damage
          _canInflictDamage = false;
          var damage = (entityConfig.damageOnAttack * scaleModifier).floor();
          world.playerManager.playerBase.takeDamage(damage, position: attackEffectPosition());
        } else if (animationTicker?.isFirstFrame == true) {
          _canInflictDamage = true;
        }
      }
    }
  }

  void _applyBoundingConstraints(double dt) {
    if (!isAlive || world.worldStateManager.gameOver) {
      return;
    }

    // We could also perhaps apply friction here again, too, this would be caused by a high velocity throw.
    if (position.y < BoundingConstants.minYCoordinate) {
      position.y = BoundingConstants.minYCoordinate;
    }

    // Bind the entity to the left of the screen so they don't get thrown too hard off the screen.
    if (position.x < BoundingConstants.minXCoordinateOffScreen) {
      position.x = BoundingConstants.minXCoordinateOffScreen;
    }

    if (current != EntityState.dragged && world.playerManager.playerBase.entityInside(this)) {
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
      position.x = TimestepHelper.add(position.x, entityConfig.walkingForwardSpeed * scale.x, dt);
    }
  }

  void wallCollisionCalculation(double dt) {
    if (!isCollidingWithWall) {
      return;
    }

    if (current == EntityState.walking) {
      current = EntityState.attacking;
    }

    if (current == EntityState.falling) {
      current = EntityState.walking;
    }

    position = _lastValidPosition;
  }

  void fallingCalculation(double dt) {}

  void takeDamage(double damage) {
    _currentHealth -= damage;

    if (_currentHealth <= MiscConstants.eps) {
      initiateDeath();
    } else {
      world.effectManager.addDamageText(damage.toInt(), absoluteCenter);
    }
  }

  void initiateDeath() {
    if (current != EntityState.dying) {
      _currentHealth = 0;
      current = EntityState.dying;
      world.playerManager.mutateGold(entityConfig.goldOnKill);
      world.effectManager.addGoldText(entityConfig.goldOnKill, absoluteCenter);

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
