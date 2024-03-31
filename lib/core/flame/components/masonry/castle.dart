import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/blue_flame.dart';
import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/rock_pile.dart';
import 'package:defend_your_flame/core/flame/components/masonry/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class Castle extends PositionComponent with HasAncestor<MainWorld>, HasVisibility {
  int _health = 100;
  int _totalHealth = 100;

  int get currentHealth => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;

  late final Wall _wall = Wall(verticalRange: 140)
    ..position = Vector2(0, 0)
    ..anchor = Anchor.bottomLeft;

  late final RockPile _rockPile = RockPile()
    ..position = Vector2(wallWidth + ((width - wallWidth) / 2) - 40, -60)
    ..anchor = Anchor.bottomCenter;

  late final PurpleFlame _topPurpleFlame = PurpleFlame()
    ..position = _rockPile.absoluteCenter - Vector2(0, _rockPile.scaledSize.y / 2)
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2.all(1.6);

  late final BlueFlame _topBlueFlame = BlueFlame()
    ..position = Vector2(200, -23)
    ..scale = Vector2.all(2);

  bool get destroyed => _health <= 0;
  double get wallWidth => _wall.scaledSize.x;

  @override
  FutureOr<void> onLoad() {
    add(_wall);
    add(_topPurpleFlame);
    add(_rockPile);
    // add(_topBlueFlame);
    return super.onLoad();
  }

  void reset() {
    _health = _totalHealth;
    isVisible = true;
    _wall.isVisible = true;
    _topPurpleFlame.isVisible = true;
    _topBlueFlame.isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    _health -= damage;
    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      ancestor.effectManager.addDamageText(damage, position);
    }

    if (destroyed) {
      _topPurpleFlame.isVisible = false;
      _topBlueFlame.isVisible = false;
      isVisible = false;

      if (ancestor.worldStateManager.playing) {
        ancestor.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }
}
