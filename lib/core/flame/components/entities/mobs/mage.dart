import 'package:defend_your_flame/constants/damage_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/animation_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/configs/entity_config.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_draggable_collisions.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_idle_time.dart';
import 'package:defend_your_flame/core/flame/components/projectiles/concrete_curving_projectiles/mage_curving_projectile.dart';
import 'package:defend_your_flame/core/flame/helpers/entity_helper.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';

class Mage extends Entity with HasIdleTime, HasDraggableCollisions, HoverCallbacks, HasMouseHover {
  static final EntityConfig _mageConfig = EntityConfig(
    entityResourceName: 'mage',
    defaultSize: Vector2(160, 128),
    defaultScale: 1.2,
    idleConfig: AnimationConfig(
      stepTime: 0.14,
      frames: 8,
    ),
    walkingConfig: AnimationConfig(
      stepTime: 0.14,
      frames: 8,
    ),
    attackingConfig: AnimationConfig(
      stepTime: 0.15,
      frames: 13,
    ),
    dyingConfig: AnimationConfig(
      stepTime: 0.08,
      frames: 10,
    ),
    baseWalkingSpeed: 31,
    damageOnAttack: 12,
    goldOnKill: 14,
    totalHealth: DamageConstants.fallDamage * 4,
    attackRange: () => GlobalVars.rand.nextInt(120) + 140,
    timeSpendIdle: TimeSpendIdle.moderate,
  );

  late final RectangleHitbox _hitbox = EntityHelper.createRectangleHitbox(
      size: Vector2(36, 50),
      anchor: Anchor.topCenter,
      position: Vector2(80, 67),
      collisionType: CollisionType.active,
      isSolid: true);

  Mage({super.scaleModifier}) : super(entityConfig: _mageConfig) {
    setDisappearSpeedFactor(2);
  }

  @override
  List<ShapeHitbox> addHitboxes() {
    return [_hitbox];
  }

  @override
  void render(Canvas canvas) {
    EntityHelper.drawHealthBar(canvas,
        entity: this, width: _hitbox.width, centerPosition: Vector2(_hitbox.center.x, _hitbox.topLeftPosition.y));

    super.render(canvas);
  }

  @override
  void performAttack() {
    // We want it to come from the top right of the hitbox
    var attackPosition =
        _hitbox.absoluteTopLeftPosition + Vector2(_hitbox.width, 0) + (Vector2(8, -22) * scaleModifier);

    world.projectileManager.addProjectile(MageCurvingProjectile(
        initialPosition: attackPosition,
        targetPosition: world.playerBase.wall.absoluteCenter,
        damage: _mageConfig.damageOnAttack));
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Inflict damage on tap and make them idle if they were walking.
    takeDamage(DamageConstants.clickingDamage, position: (event.localPosition * scale.x) + topLeftPosition);

    forceResetIdleTimer();

    if (current == EntityState.walking) {
      toggleToIdle(shortDuration: true);
    }
  }

  static Mage spawn({required double skyHeight}) {
    var scaleModifier = MiscHelper.randomDouble(minValue: 1.1, maxValue: 1.25);
    var mage = Mage(scaleModifier: scaleModifier);

    // Magic ✨
    var startPosition = Vector2(
      -GlobalVars.rand.nextDouble() * mage.scaledSize.x / 2,
      GlobalVars.rand.nextDouble() * (skyHeight / 3) + (skyHeight / 2.5),
    );

    mage.position = startPosition - Vector2(mage.scaledSize.x, mage.scaledSize.y / 2.3);
    return mage;
  }
}
