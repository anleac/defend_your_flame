import 'dart:async';

import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base_component.dart';
import 'package:defend_your_flame/core/flame/components/masonry/totems/stone_totem.dart';
import 'package:defend_your_flame/core/flame/components/projectiles/concrete_curving_projectiles/attack_totem_curving_projectile.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';

class AttackTotem extends PlayerBaseComponent {
  static const double baseSpeed = 400;

  final StoneTotem _stoneTotem = StoneTotem();
  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..scale = Vector2(1.4, 2.3)
    ..position = Vector2(_stoneTotem.size.x / 2, 0)
    ..anchor = Anchor.bottomCenter;

  double _nextAttackCounter = 0;
  double _attackCooldown = 2;

  AttackTotem() {
    size = _stoneTotem.size;
    scale = Vector2.all(0.4);
  }

  @override
  FutureOr<void> onLoad() {
    add(_stoneTotem);
    add(_firePitFlame);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _nextAttackCounter += dt;

    if (_nextAttackCounter >= _attackCooldown) {
      _nextAttackCounter = 0;
      _attackCooldown = GlobalVars.rand.nextDouble() * 3 + 1.5;

      if (DebugConstants.superPoweredTotems) {
        _attackCooldown /= 4;
      }

      if (world.worldStateManager.playing) {
        var randomEnemy = world.entityManager.randomVisibleAliveEntity();

        if (randomEnemy != null) {
          world.projectileManager.addProjectile(AttackTotemCurvingProjectile(
              initialPosition: absoluteCenter - Vector2(0, scaledSize.y / 2),
              targetPosition: randomEnemy.absoluteCenterOfMainHitbox(),
              damage: DamageConstants.fallDamageAsInt,
              targetXVelocity: randomEnemy.isWalking ? randomEnemy.entityConfig.walkingForwardSpeed.toDouble() : 0,
              horizontalPixelsPerSecond: baseSpeed + (GlobalVars.rand.nextDouble() * 100)));
        }
      }
    }
  }
}
