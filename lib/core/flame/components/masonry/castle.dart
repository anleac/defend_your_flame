import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/rock_fire_pit.dart';
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

  late final RockFirePit _rockFirePit = RockFirePit()
    ..position = Vector2(wallWidth + ((width - wallWidth) / 2) - 40, -60)
    ..anchor = Anchor.bottomLeft;

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = _rockFirePit.center - Vector2(15, -5)
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2(1.2, 2.5);

  bool get destroyed => _health <= 0;
  double get wallWidth => _wall.scaledSize.x;

  @override
  FutureOr<void> onLoad() {
    add(_wall);
    add(_rockFirePit);
    add(_firePitFlame);
    return super.onLoad();
  }

  void reset() {
    _health = _totalHealth;
    isVisible = true;
    _wall.isVisible = true;
    _firePitFlame.isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    _health -= damage;
    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      ancestor.effectManager.addDamageText(damage, position);
    }

    if (destroyed) {
      _firePitFlame.isVisible = false;
      isVisible = false;

      if (ancestor.worldStateManager.playing) {
        ancestor.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }
}
