import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/disappear_on_death.dart';
import 'package:defend_your_flame/core/flame/components/entities/draggable_entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Skeleton extends DraggableEntity with DisappearOnDeath {
  static final EntityConfig _skeletonConfig = EntityConfig(
    entityResourceName: 'skeleton',
    defaultSize: Vector2(22, 33),
    attackingSize: Vector2(43, 37),
    defaultScale: 1.65,
    walkingConfig: AnimationConfig(frames: 13, stepTime: 0.092),
    attackingConfig: AnimationConfig(frames: 18, stepTime: 0.1),
    dragConfig: AnimationConfig(frames: 4, stepTime: 0.2),
    dyingConfig: AnimationConfig(frames: 15, stepTime: 0.07),
    damageOnAttack: 8,
    goldOnKill: 3,
    baseWalkingSpeed: 20,
  );

  final Vector2 _hitboxAttackingOffset = Vector2(3, 4);

  bool _attackingState = false;

  late final RectangleHitbox _hitBox =
      EntityHelper.createRectangleHitbox(size: Vector2(16, 25), position: Vector2(8, 33), anchor: Anchor.bottomCenter);

  Skeleton({super.scaleModifier, super.modifiedWalkingSpeed}) : super(entityConfig: _skeletonConfig) {
    // We use the bottom left anchor because the attack animation is larger than the walking one, to stop the skeleton from moving when attacking.
    anchor = Anchor.bottomLeft;
  }

  @override
  Vector2? attackEffectPosition() {
    return position + Vector2(scaledSize.x - 15, -scaledSize.y / 2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [_hitBox];
  }

  @override
  void updateSize(Vector2 newSize, {required bool attacking}) {
    super.updateSize(newSize, attacking: attacking);

    if (attacking != _attackingState) {
      _attackingState = attacking;
    } else {
      return;
    }

    if (attacking) {
      _hitBox.position += _hitboxAttackingOffset;
      position -= Vector2(_hitboxAttackingOffset.x, 0);
    } else {
      _hitBox.position -= _hitboxAttackingOffset;
      position += Vector2(_hitboxAttackingOffset.x, 0);
    }
  }

  static Skeleton spawn({required Vector2 position, required double speedFactor}) {
    final scaleModifier = MiscHelper.randomDouble(minValue: 1, maxValue: 1.2);
    final skeleton =
        Skeleton(scaleModifier: scaleModifier, modifiedWalkingSpeed: _skeletonConfig.baseWalkingSpeed * speedFactor);

    // Since we are using the bottom left anchor, we need to adjust the position.
    skeleton.position = position + Vector2(-skeleton.scaledSize.x, skeleton.scaledSize.y);
    return skeleton;
  }
}
