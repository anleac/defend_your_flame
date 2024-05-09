import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
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

  final AnimationConfig? idleConfig;
  final AnimationConfig? dragConfig;

  final AnimationConfig walkingConfig;
  final AnimationConfig attackingConfig;
  final AnimationConfig dyingConfig;

  final int walkingForwardSpeed;

  final double totalHealth;

  final int damageOnAttack;
  final int goldOnKill;

  final double dragResistance;

  final double Function()? attackRange;
  final TimeSpendIdle timeSpendIdle;

  EntityConfig({
    required this.entityResourceName,
    required this.defaultSize,
    this.defaultScale = 1.0,
    this.attackingSize,
    this.totalHealth = DamageConstants.fallDamage,
    this.dragConfig,
    this.idleConfig,
    required this.walkingConfig,
    required this.attackingConfig,
    required this.dyingConfig,
    required this.walkingForwardSpeed,
    required this.damageOnAttack,
    required this.goldOnKill,
    this.dragResistance = 1.0,
    this.attackRange,
    this.timeSpendIdle = TimeSpendIdle.none,
  });
}
