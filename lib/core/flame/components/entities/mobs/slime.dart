import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity_config.dart';
import 'package:flame/components.dart';

class Slime extends WalkingEntity {
  static final WalkingEntityConfig _slimeConfig = WalkingEntityConfig(
    entityResourceName: 'slime',
    defaultSize: Vector2(34, 27),
    walkingConfig: AnimationConfig(
      stepTime: 0.12,
      frames: 4,
    ),
    dragConfig: AnimationConfig(
      stepTime: 0.1,
      frames: 4,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.07,
      frames: 4,
    ),
    walkingForwardSpeed: 40,
  );

  Slime({super.scaleModifier}) : super(entityConfig: _slimeConfig);
}
