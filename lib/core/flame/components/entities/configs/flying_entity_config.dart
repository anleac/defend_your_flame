import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';

class FlyingEntityConfig {
  final AnimationConfig? idleConfig;

  // I first wanted to make this a child class of entity config, but it wasn't so clean as dart
  // required each field to be initialized AND stated in the constructor.
  final EntityConfig entityConfig;

  // Function that gets a double value to represent how far away from the wall it should stop to attack
  final double Function() attackRange;

  FlyingEntityConfig({
    this.idleConfig,
    required this.entityConfig,
    required this.attackRange,
  });
}
