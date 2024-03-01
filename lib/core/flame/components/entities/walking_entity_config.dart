import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:flame/components.dart';

/// WalkingEntityConfig is a class that holds the information used to define
/// various concrete implementations of the WalkingEntity class.
/// Given that most will share the same underlying logic, it makes sense to
/// simple have a differing config and re-use a shared class handler.
class WalkingEntityConfig {
  final String entityResourceName;

  final Vector2 defaultSize;
  final double defaultScale;

  final AnimationConfig walkingConfig;
  final AnimationConfig dragConfig;
  final AnimationConfig dyingConfig;

  final int walkingForwardSpeed;

  final bool canBePickedUp;

  WalkingEntityConfig({
    required this.entityResourceName,
    required this.defaultSize,
    this.defaultScale = 1.0,
    required this.walkingConfig,
    required this.dragConfig,
    required this.dyingConfig,
    required this.walkingForwardSpeed,
    this.canBePickedUp = true,
  });
}
