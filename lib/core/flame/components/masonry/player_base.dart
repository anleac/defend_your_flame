import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/masonry/rock_fire_pit.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerBase extends PositionComponent with HasWorldReference<MainWorld>, HasVisibility {
  static const double baseWidth = 280;
  static const double baseHeight = 180;
  static const double _wallOffset = 10;

  late final Wall _wall = Wall(verticalRange: baseHeight - _wallOffset * 2)..position = Vector2(0, _wallOffset);

  late final RockFirePit _rockFirePit = RockFirePit()
    ..position = Vector2(wallWidth + ((width - wallWidth) / 2), baseHeight / 2 - 20);

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = _rockFirePit.center - Vector2(34, 10)
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2(1.2, 2.5);

  // This excludes the wall
  late final Rect _exposedAreaRect = Rect.fromLTWH(
      wallWidth + position.x, position.y - _wallOffset, width + BoundingConstants.maxXCoordinateOffScreen, baseHeight);

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
  }

  void takeDamage(int damage, {Vector2? position}) {
    _wall.takeDamage(damage, position: position);

    if (destroyed) {
      isVisible = false;

      if (world.worldStateManager.playing) {
        world.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // This is used for debugging
    var relativeRect = _exposedAreaRect.translate(-position.x, -position.y);
    canvas.drawRect(relativeRect, DebugConstants.debugPaint);
  }

  bool entityInside(Entity entity) {
    // This is used instead of a collision box as this is more efficient
    if (entity.position.x < world.worldWidth - baseWidth) {
      return false;
    }

    return _exposedAreaRect.contains(entity.center.toOffset());
  }
}
