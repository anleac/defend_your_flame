import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/physics_constants.dart';
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

class Entity extends SpriteAnimationGroupComponent<EntityState>
    with ParentIsA<EntityManager>, HasWorldReference<MainWorld>, HasGameReference<MainGame>, HasVisibility {
  final EntityConfig entityConfig;

  late final double _pickupHeight;

  bool _canInflictDamage = false;

  bool get isAlive => current != EntityState.dying;

  Vector2 _fallVelocity = Vector2.zero();

  Rect get localCollisionRect =>
      Rect.fromLTWH(_scaledCollisionOffset.x, _scaledCollisionOffset.y, _scaledCollisionSize.x, _scaledCollisionSize.y);

  late Vector2 _attackingSize;

  late Vector2 _scaledCollisionSize;
  late Vector2 _scaledCollisionOffset;

  final double extraXBoundaryOffset;

  Entity({required this.entityConfig, double scaleModifier = 1, this.extraXBoundaryOffset = 0}) {
    size = entityConfig.defaultSize;
    _attackingSize = entityConfig.attackingSize ?? size;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);

    _calculateCollisionSize();
  }

  _calculateCollisionSize() {
    _scaledCollisionSize = (entityConfig.collisionSize ?? size);

    var offset =
        current == EntityState.attacking ? entityConfig.attackingCollisionOffset : entityConfig.collisionOffset;
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
    _pickupHeight = position.y;
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

    super.render(canvas);
  }

  void overrideFallVelocity(Vector2 newFallVelocity) {
    _fallVelocity = newFallVelocity;
  }

  // Intended to be overridden by subclasses
  Vector2? attackEffectPosition() => null;

  void _updateMovement(double dt) {
    _attackingLogic(dt);
    _logicCalculation(dt);
    _fallingCalculation(dt);
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
          world.castle.takeDamage(entityConfig.damageOnAttack, position: attackEffectPosition());
        } else if (animationTicker?.isFirstFrame == true) {
          _canInflictDamage = true;
        }
      }
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
    } else if (position.x >= parent.positionXBoundary + 50 && current == EntityState.walking) {
      // TODO this is an MVP way to remove a edge case from early development, definitely re-visit this and remove it.
      initiateDeath();
    } else if (position.x <= parent.positionXBoundary + 15 && current == EntityState.walking) {
      current = EntityState.attacking;
    }
  }

  void _fallingCalculation(double dt) {
    // Always do this, even if not falling, to scale drag velocity updates.
    _fallVelocity = PhysicsHelper.applyFriction(_fallVelocity, dt);
    PhysicsHelper.clampVelocity(_fallVelocity);

    if (current == EntityState.falling) {
      _fallVelocity = PhysicsHelper.applyGravity(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          // Random 'death velocity'
          initiateDeath();
        } else {
          current = EntityState.walking;
        }
      }
    }
  }

  void initiateDeath() {
    if (current != EntityState.dying) {
      current = EntityState.dying;
      world.effectManager.addGoldText(entityConfig.goldOnKill, absoluteCenter);
    }
  }
}
