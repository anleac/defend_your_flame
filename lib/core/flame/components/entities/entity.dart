import 'package:defend_your_flame/constants/physics_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/physics_helper.dart';
import 'package:defend_your_flame/helpers/timestep/debug/timestep_faker.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';

class Entity extends SpriteAnimationGroupComponent<EntityState>
    with ParentIsA<EntityManager>, HasGameReference<MainGame>, HasVisibility {
  final EntityConfig entityConfig;

  late final double _pickupHeight;

  bool get isAlive => current != EntityState.dying;

  Vector2 _fallVelocity = Vector2.zero();

  late Vector2 _attackingSize;

  Entity({required this.entityConfig, double scaleModifier = 1}) {
    size = entityConfig.defaultSize;
    _attackingSize = entityConfig.attackingSize ?? size;
    scale = Vector2.all(entityConfig.defaultScale * scaleModifier);
  }

  @override
  void onMount() {
    super.onMount();
    _pickupHeight = position.y;
  }

  @override
  Future<void> onLoad() async {
    final walkingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/walk',
        stepTime: entityConfig.walkingConfig.stepTime / scale.x, frames: entityConfig.walkingConfig.frames, loop: true);

    final attackingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/attack',
        stepTime: entityConfig.attackingConfig.stepTime / scale.x,
        frames: entityConfig.attackingConfig.frames,
        loop: true);

    final dragSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/drag',
        stepTime: entityConfig.dragConfig.stepTime / scale.x, frames: entityConfig.dragConfig.frames, loop: true);

    final dyingSprite = SpriteManager.getAnimation('mobs/${entityConfig.entityResourceName}/dying',
        stepTime: entityConfig.dyingConfig.stepTime / scale.x, frames: entityConfig.dyingConfig.frames, loop: false);

    animations = {
      EntityState.walking: walkingSprite,
      EntityState.attacking: attackingSprite,
      EntityState.dragged: dragSprite,
      EntityState.falling: dragSprite,
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

  void overrideFallVelocity(Vector2 newFallVelocity) {
    _fallVelocity = newFallVelocity;
  }

  void _updateMovement(double dt) {
    _logicCalculation(dt);
    _fallingCalculation(dt);
  }

  void _logicCalculation(double dt) {
    // Special case where the attacking animation is bigger than the default size.
    size = current == EntityState.attacking ? _attackingSize : entityConfig.defaultSize;

    if (current == EntityState.walking && position.x + (_attackingSize.x / 4) < parent.positionXBoundary) {
      position.x = TimestepHelper.add(position.x, entityConfig.walkingForwardSpeed * scale.x, dt);
    } else if (position.x >= parent.positionXBoundary + 50 && current == EntityState.walking) {
      // TODO this is an MVP way to remove a edge case from early development, definitely re-visit this and remove it.
      current = EntityState.dying;
    } else if (position.x <= parent.positionXBoundary + 15 && current == EntityState.walking) {
      current = EntityState.attacking;
    }
  }

  void _fallingCalculation(double dt) {
    if (current == EntityState.falling) {
      _fallVelocity = PhysicsHelper.applyGravityFrictionAndClamp(_fallVelocity, dt);
      position = TimestepHelper.addVector2(position, _fallVelocity, dt);

      if (position.y >= _pickupHeight) {
        if (_fallVelocity.y > PhysicsConstants.maxVelocity.y * 0.4) {
          // Random 'death velocity'
          current = EntityState.dying;
        } else {
          current = EntityState.walking;
        }
      }
    }
  }
}
