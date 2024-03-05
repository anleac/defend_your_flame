import 'package:defend_your_flame/core/flame/components/entities/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity_config.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class Skeleton extends DraggableEntity {
  static final EntityConfig _skeletonConfig = EntityConfig(
    entityResourceName: 'skeleton',
    defaultSize: Vector2(22, 33),
    attackingSize: Vector2(43, 37),
    defaultScale: 1.2,
    walkingConfig: AnimationConfig(frames: 13, stepTime: 0.09),
    attackingConfig: AnimationConfig(frames: 18, stepTime: 0.1),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 15, stepTime: 0.07),
    walkingForwardSpeed: 25,
  );

  Skeleton({super.scaleModifier}) : super(entityConfig: _skeletonConfig) {
    debugMode = kDebugMode;
  }
}
