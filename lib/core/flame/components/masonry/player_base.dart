import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/rock_fire_pit.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';

class PlayerBase extends PositionComponent with HasAncestor<MainWorld>, HasVisibility {
  static const double baseWidth = 240;
  static const double baseHeight = 180;
  static const double wallOffset = 10;

  int _health = 100;
  int _totalHealth = 100;

  int get currentHealth => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;

  late final Wall _wall = Wall(verticalRange: baseHeight - wallOffset * 2)..position = Vector2(0, wallOffset);

  late final RockFirePit _rockFirePit = RockFirePit()
    ..position = Vector2(wallWidth + ((width - wallWidth) / 2) - 25, baseHeight / 2 - 20);

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = _rockFirePit.center - Vector2(15, -5)
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2(1.2, 2.5);

  bool get destroyed => _health <= 0;
  double get wallWidth => _wall.scaledSize.x;

  PlayerBase() : super(size: Vector2(baseWidth, baseHeight));

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
