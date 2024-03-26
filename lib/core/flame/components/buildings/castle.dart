import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/blue_flame.dart';
import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class Castle extends SpriteComponent with ParentIsA<MainWorld>, HasVisibility {
  int _health = 100;
  int _totalHealth = 100;

  // TODO eventually shift castle into a wrapped helper, that will hold other stats.
  int _gold = 0;

  int get currentHealth => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;
  int get totalGold => _gold;

  late final PurpleFlame _topPurpleFlame = PurpleFlame()
    ..position = Vector2(373, 46)
    ..scale = Vector2.all(2);

  late final BlueFlame _topBlueFlame = BlueFlame()
    ..position = Vector2(200, -23)
    ..scale = Vector2.all(2.6);

  bool get destroyed => _health <= 0;

  Castle()
      : super(
            size: Vector2(871, 526),
            sprite: SpriteManager.getSprite('castle'),
            scale: Vector2.all(0.65),
            anchor: Anchor.topLeft);
  @override
  FutureOr<void> onLoad() {
    add(_topPurpleFlame);
    add(_topBlueFlame);
    return super.onLoad();
  }

  // TODO: Update this properly towards beta to take into account load states etc.
  void restart() {
    _gold = 0;
    _health = _totalHealth;
    isVisible = true;
    _topPurpleFlame.isVisible = true;
    _topBlueFlame.isVisible = true;
  }

  void addGold(int gold) => _gold += gold;

  void takeDamage(int damage, {Vector2? position}) {
    _health -= damage;
    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      parent.effectManager.addDamageText(damage, position);
    }

    if (destroyed) {
      _topPurpleFlame.isVisible = false;
      _topBlueFlame.isVisible = false;
      isVisible = false;

      if (parent.worldStateManager.playing) {
        parent.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }
}
