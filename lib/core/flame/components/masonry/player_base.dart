import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/masonry/fire_pit.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerBase extends PositionComponent with HasWorldReference<MainWorld>, HasVisibility {
  static const double baseWidthWithoutWall = 210;
  static const double baseWidth = baseWidthWithoutWall + Wall.wallAreaWidth;
  static const double baseHeight = 180;

  late final Rect _innerBaseRect = Rect.fromLTWH(Wall.wallAreaWidth + position.x, position.y + Wall.wallYOffset,
      width + BoundingConstants.maxXCoordinateOffScreen, baseHeight - (Wall.wallYOffset * 2));

  late final Wall _wall = Wall()..position = Vector2(0, Wall.wallYOffset);
  late final FirePit _firePit = FirePit()
    ..position = Vector2(Wall.wallAreaWidth + (baseWidthWithoutWall / 2), baseHeight / 2 - 10);

  int _gold = 0;

  int get totalGold => _gold;
  bool get destroyed => _wall.health <= 0;
  Wall get wall => _wall;

  PlayerBase({required double worldWidth, required double worldHeight})
      : super(
            size: Vector2(baseWidth, baseHeight), position: Vector2(worldWidth - baseWidth, worldHeight - baseHeight));

  @override
  FutureOr<void> onLoad() {
    add(_wall);
    add(_firePit);
    return super.onLoad();
  }

  void reset() {
    _gold = 0;
    _wall.reset();
    isVisible = true;
  }

  void mutateGold(int gold) => _gold += gold;

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

    if (DebugConstants.drawEntityCollisionBoxes) {
      // This is used for debugging
      var relativeRect = _innerBaseRect.translate(-position.x, -position.y);
      canvas.drawRect(relativeRect, DebugConstants.debugPaint);
    }
  }

  bool entityInside(Entity entity) {
    // This is used instead of a collision box as this is more efficient
    if (entity.position.x < world.worldWidth - baseWidth) {
      return false;
    }

    return _innerBaseRect.contains(entity.center.toOffset());
  }
}
