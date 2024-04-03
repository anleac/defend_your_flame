import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/debug/debug_helper.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/debug/timestep_faker.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/rendering.dart';

class Entity extends SpriteAnimationGroupComponent<EntityState>
    with ParentIsA<EntityManager>, HasWorldReference<MainWorld>, HasGameReference<MainGame>, HasVisibility {
  final EntityConfig entityConfig;

  bool _canInflictDamage = false;

  bool get isAlive => _currentHealth > MiscConstants.eps;

  late double _currentHealth;

  Rect get localCollisionRect =>
      Rect.fromLTWH(_scaledCollisionOffset.x, _scaledCollisionOffset.y, _scaledCollisionSize.x, _scaledCollisionSize.y);

  late Vector2 _attackingSize;

  late Vector2 _scaledCollisionSize;
  late Vector2 _scaledCollisionOffset;

  late Vector2 _startingPosition;

  final double extraXBoundaryOffset;
  final double scaleModifier;

  Entity({required this.entityConfig, this.scaleModifier = 1, this.extraXBoundaryOffset = 0}) {
    size = entityConfig.defaultSize;
    _attackingSize = entityConfig.attackingSize ?? size;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);
    _currentHealth = entityConfig.totalHealth;

    _calculateCollisionSize();
  }

  _calculateCollisionSize() {
    _scaledCollisionSize = (entityConfig.collisionSize ?? size);

    var offset = current == EntityState.attacking
        ? entityConfig.attackingCollisionOffset ?? entityConfig.collisionOffset
        : entityConfig.collisionOffset;

    _scaledCollisionOffset = offset ?? Vector2.zero();

    if (entityConfig.collisionAnchor == Anchor.bottomLeft) {
      // We need to adjust the offset to account for the fact that the anchor is bottom left.
      // For this we need to find the diff between the position, size, and collision size.
      var collisionSizeDiff = size - _scaledCollisionSize;
      // We only care about Y, since the anchor is bottom left.
      _scaledCollisionOffset += Vector2(0, collisionSizeDiff.y);
    }
  }

  _updateSize(Vector2 newSize) {
    if (size != newSize) {
      size = newSize;
      _calculateCollisionSize();
    }
  }

  @override
  void onMount() {
    super.onMount();
    _startingPosition = position.clone();
  }

  bool pointInside(Vector2 point) {
    return isVisible &&
        PhysicsHelper.pointIsInsideBounds(point: point, size: _scaledCollisionSize, offset: _scaledCollisionOffset);
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
  }

  @override
  void update(double dt) {
    var fakeTimestep = game.findByKeyName<TimestepFaker>(TimestepFaker.componentKey);

    if (fakeTimestep != null) {
      fakeTimestep.updateWithFakeTimestep(dt, _updateMovement);
    } else {
      _updateMovement(dt);
    }

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (DebugConstants.drawEntityCollisionBoxes) {
      DebugHelper.drawEntityCollisionBox(canvas, this);
    }

    if (entityConfig.totalHealth > DamageConstants.fallDamage + MiscConstants.eps && isAlive) {
      _drawHealthBar(canvas);
    }

    super.render(canvas);
  }

  // TODO one day lets refactor this out to clean up this file a bit
  void _drawHealthBar(Canvas canvas) {
    const healthBarHeight = 2.0;
    const healthBarWidthOffset = 2;
    final healthBarWidth = _scaledCollisionSize.x + (healthBarWidthOffset * 2);

    final healthBarRect = Rect.fromLTWH(_scaledCollisionOffset.x - healthBarWidthOffset,
        _scaledCollisionOffset.y - (healthBarHeight * 3), healthBarWidth, healthBarHeight);

    final healthBarBackgroundPaint = Paint()
      ..color = const Color.fromARGB(150, 66, 0, 0)
      ..style = PaintingStyle.fill;

    final healthBarBackgroundRect =
        Rect.fromLTWH(healthBarRect.left, healthBarRect.top, healthBarWidth, healthBarHeight);

    canvas.drawRect(healthBarBackgroundRect, healthBarBackgroundPaint);

    final healthBarFillPaint = Paint()
      ..color = const Color.fromARGB(150, 228, 0, 0)
      ..style = PaintingStyle.fill;

    final healthBarFillRect = Rect.fromLTWH(healthBarRect.left, healthBarRect.top,
        healthBarWidth * _currentHealth / entityConfig.totalHealth, healthBarHeight);

    canvas.drawRect(healthBarFillRect, healthBarFillPaint);
  }

  // Intended to be overridden by subclasses
  Vector2? attackEffectPosition() => null;

  void _updateMovement(double dt) {
    _attackingLogic(dt);
    _logicCalculation(dt);
    fallingCalculation(dt);
    _applyBoundingConstraints(dt);
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

    if (position.x > world.worldWidth + BoundingConstants.maxXCoordinateOffScreen) {
      teleportToStart();
    }
  }

  void _logicCalculation(double dt) {
    // Special case where the attacking animation is bigger than the default size.
    if (current == EntityState.attacking) {
      _updateSize(_attackingSize);
    } else {
      _updateSize(entityConfig.defaultSize);
    }

    if (current == EntityState.walking &&
        position.x + (_attackingSize.x / 4) <
            parent.positionXBoundary - extraXBoundaryOffset + entityConfig.extraXBoundaryOffset) {
      position.x = TimestepHelper.add(position.x, entityConfig.walkingForwardSpeed * scale.x, dt);
    } else if (position.x <= parent.positionXBoundary + 15 && current == EntityState.walking) {
      current = EntityState.attacking;
    }
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
    }
  }

  void teleportToStart() {
    position = _startingPosition;
    current = EntityState.walking;
  }
}
