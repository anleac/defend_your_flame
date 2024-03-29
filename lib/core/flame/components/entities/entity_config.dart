import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:flame/components.dart';

/// EntityConfig is a class that holds the information used to define
/// various concrete implementations of the WalkingEntity class.
/// Given that most will share the same underlying logic, it makes sense to
/// simple have a differing config and re-use a shared class handler.
class EntityConfig {
  final String entityResourceName;

  final Vector2 defaultSize;
  final Vector2? attackingSize;
  final double defaultScale;

  // For interactions
  final Vector2? collisionSize;
  final Vector2? collisionOffset;
  final Vector2? attackingCollisionOffset;
  final Anchor? collisionAnchor;

  final int extraXBoundaryOffset;

  final AnimationConfig? idleConfig;
  final AnimationConfig? dragConfig;
  final AnimationConfig walkingConfig;
  final AnimationConfig attackingConfig;
  final AnimationConfig dyingConfig;

  final int walkingForwardSpeed;

  final double totalHealth;

  final int damageOnAttack;
  final int goldOnKill;

  final bool canBePickedUp;

  EntityConfig({
    required this.entityResourceName,
    required this.defaultSize,
    this.defaultScale = 1.0,
    this.attackingSize,
    this.collisionSize,
    this.collisionOffset,
    this.attackingCollisionOffset,
    this.totalHealth = DamageConstants.fallDamage,
    this.collisionAnchor = Anchor.topLeft,
    this.idleConfig,
    this.dragConfig,
    this.extraXBoundaryOffset = 0,
    required this.walkingConfig,
    required this.attackingConfig,
    required this.dyingConfig,
    required this.walkingForwardSpeed,
    required this.damageOnAttack,
    required this.goldOnKill,
    this.canBePickedUp = true,
  });
}
