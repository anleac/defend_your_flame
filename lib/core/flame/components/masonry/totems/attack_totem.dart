import 'dart:async';

import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base_component.dart';
import 'package:defend_your_flame/core/flame/components/masonry/totems/stone_totem.dart';
import 'package:defend_your_flame/core/flame/components/projectiles/concrete_curving_projectiles/attack_totem_curving_projectile.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:flame/components.dart';

class AttackTotem extends PlayerBaseComponent {
  final StoneTotem _stoneTotem = StoneTotem();
  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..scale = Vector2(1.4, 2.3)
    ..position = Vector2(_stoneTotem.size.x / 2, 0)
    ..anchor = Anchor.bottomCenter;

  double _nextAttackCounter = 0;
  double _attackCooldown = 2;

  AttackTotem() {
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
      _attackCooldown = GlobalVars.rand.nextDouble() * 2.5 + 1;

      if (world.worldStateManager.playing) {
        var randomEnemy = world.entityManager.randomVisibleAliveEntity();

        if (randomEnemy != null) {
          world.projectileManager.addProjectile(AttackTotemCurvingProjectile(
              initialPosition: absoluteCenter,
              targetPosition: randomEnemy.absoluteCenter,
              damage: 8,
              targetXVelocity: randomEnemy.isWalking ? randomEnemy.entityConfig.walkingForwardSpeed.toDouble() : 0));
        }
      }
    }
  }
}
