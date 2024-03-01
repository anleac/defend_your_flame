import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/walking_entity_config.dart';
import 'package:flame/components.dart';

enum SkeletonState { walking, dragged, falling, dying }

class Skeleton extends WalkingEntity {
  static final WalkingEntityConfig _skeletonConfig = WalkingEntityConfig(
    entityResourceName: 'skeleton',
    defaultSize: Vector2(22, 33),
    scale: 1.2,
    walkingConfig: AnimationConfig(frames: 13, stepTime: 0.09),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 15, stepTime: 0.07),
    walkingForwardSpeed: 25,
  );

  Skeleton() : super(entityConfig: _skeletonConfig);
}
