import 'dart:math';

import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_renderer.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Wall extends PositionComponent with HasVisibility, HasWorldReference<MainWorld> {
  // The offset from the bottom of the wall to the bottom of the base
  static const double wallYOffset = 10;
  static const double wallAreaWidth = 80;

  static const double verticalRange = PlayerBase.baseHeight - wallYOffset * 2;

  late final WallRenderer _wallRenderer = WallRenderer(verticalRange: verticalRange)..size = size;

  WallType _wallType = WallType.barricade;

  // Wall stats that need to be carefully reset when upgrading the wall, loading a save game, restarting game, etc.
  // To make this less error prone, we centralize this logic in `_setWallStats`
  late int _totalHealth;
  late int _health;
  late int _defenseValue;

  PolygonHitbox? _boundingBox;

  WallType get wallType => _wallType;
  int get health => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;
  int get defenseValue => _defenseValue;

  Vector2 get wallCenter => center;
  List<Vector2> get wallCornerPoints => _wallRenderer.wallCornerPoints;
  List<Rect> get solidBoxes => _wallRenderer.solidBoxes;

  Wall() {
    _setWallStats();
  }

  _setWallStats({bool resetWall = true}) {
    // Needed simply for rendering, not logic, but changes based on wall type.
    size = WallHelper.getWallSize(_wallType);
    scale = WallHelper.getScale(_wallType);
    _wallRenderer.size = size;

    _totalHealth = WallHelper.totalHealth(_wallType);
    _defenseValue = WallHelper.defenseValue(_wallType);

    if (resetWall) {
      _health = _totalHealth;
    }
  }

  @override
  void onLoad() {
    super.onLoad();
    add(_wallRenderer);

    updateWallType(_wallType, firstLoad: true);
  }

  _clearAndAddHitbox() {
    _boundingBox?.removeFromParent();
    _wallRenderer.updateWallRenderValues();

    add(
      _boundingBox = PolygonHitbox(_wallRenderer.wallCornerPoints)
        ..renderShape = DebugConstants.drawWallBoundaryBoxes
        ..paint = DebugConstants.faintDebugPaint,
    );
  }

  void updateWallType(WallType wallType, {bool firstLoad = false, bool resetWall = false}) {
    if (!firstLoad && _wallType == wallType && !resetWall) {
      return;
    }

    _wallType = wallType;

    var newTotalHealth = WallHelper.totalHealth(_wallType);
    if (_totalHealth != newTotalHealth && newTotalHealth > _totalHealth) {
      _health += newTotalHealth - _totalHealth;
    }

    _setWallStats(resetWall: resetWall);

    _clearAndAddHitbox();
    _wallRenderer.renderWallType(firstLoad: firstLoad);
  }

  void reset() {
    updateWallType(WallType.barricade, resetWall: true);

    _boundingBox?.collisionType = CollisionType.active;
    isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    var trueDamage = max(damage - _defenseValue, 1);
    _health -= trueDamage;

    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      world.effectManager.addDamageText(trueDamage, position);
    }

    if (_health <= MiscConstants.eps) {
      _boundingBox?.collisionType = CollisionType.inactive;
    }
  }

  void repairWallFor(int percent) {
    var amountToRepair = (_totalHealth * percent / 100).round();
    var amountRepairable = _totalHealth - _health;
    var totalToRepair = min(amountToRepair, amountRepairable);

    if (totalToRepair <= 0) {
      return;
    }

    _health += totalToRepair;
    world.effectManager.addHealthText(totalToRepair, absoluteCenter);
  }
}
