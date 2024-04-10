import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/masonry/rock_fire_pit.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerBase extends PositionComponent with HasWorldReference<MainWorld>, HasVisibility {
  static const double baseWidth = 240;
  static const double baseHeight = 180;
  static const double _wallOffset = 10;

  late final Wall _wall = Wall(verticalRange: baseHeight - _wallOffset * 2)..position = Vector2(0, _wallOffset);

  late final RockFirePit _rockFirePit = RockFirePit()
    ..position = Vector2(wallWidth + ((width - wallWidth) / 2) - 25, baseHeight / 2 - 20);

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = _rockFirePit.center - Vector2(33, 8)
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2(1.2, 2.5);

  // This excludes the wall
  late final Rect _exposedAreaRect =
      Rect.fromLTWH(wallWidth + position.x, position.y, width + BoundingConstants.maxXCoordinateOffScreen, baseHeight);

  bool get destroyed => _wall.health <= 0;

  double get wallWidth => _wall.scaledSize.x;
  Wall get wall => _wall;

  PlayerBase() : super(size: Vector2(baseWidth, baseHeight));

  @override
  FutureOr<void> onLoad() {
    add(_wall);
    add(_rockFirePit);
    add(_firePitFlame);
    return super.onLoad();
  }

  void reset() {
    _wall.reset();

    isVisible = true;
    _firePitFlame.isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    _wall.takeDamage(damage, position: position);

    if (destroyed) {
      _firePitFlame.isVisible = false;
      _wall.isVisible = false;
      isVisible = false;

      if (world.worldStateManager.playing) {
        world.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }

  bool entityInside(Entity entity) {
    if (entity.position.x < world.worldWidth - baseWidth) {
      return false;
    }

    return _exposedAreaRect.contains(entity.center.toOffset());
  }
}
