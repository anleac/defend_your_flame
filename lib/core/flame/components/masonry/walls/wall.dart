import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent with HasVisibility, HasWorldReference<MainWorld>, Snapshot {
  static const double verticalDiffPerRender = 30;
  double _horizontalRange = 0;
  double _verticalRange = 0;
  double _verticalRenders = 0;
  double _horizontalDiffPerRender = 0;

  late final double verticalRange;
  late Sprite _wallSprite;

  WallType _wallType = WallType.wood;
  late int _totalHealth = WallHelper.getDefaultTotalHealth(_wallType);
  int _health = 100;

  PolygonHitbox? _hitbox;
  List<Vector2> _wallCornerPoints = [];

  WallType get wallType => _wallType;
  int get health => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;

  List<Vector2> get wallCornerPoints => _wallCornerPoints;
  Vector2 get wallCenter => center;

  Wall({required this.verticalRange}) : super(size: Vector2(156, 398)) {
    scale = WallHelper.getScale(_wallType);
    renderSnapshot = true;
  }

  @override
  void onLoad() {
    super.onLoad();
    updateWallType(_wallType, firstLoad: true);
  }

  _updateRenderValues() {
    _verticalRange = verticalRange / scale.y;
    _verticalRenders = (_verticalRange / verticalDiffPerRender).ceilToDouble();

    _horizontalRange = _verticalRange * ParallaxConstants.horizontalDisplacementFactor;
    _horizontalDiffPerRender = _horizontalRange / _verticalRenders;
  }

  _clearAndAddHitbox() {
    _hitbox?.removeFromParent();

    _updateRenderValues();
    _wallCornerPoints.clear();
    _wallCornerPoints.addAll([
      Vector2(0, -size.y),
      Vector2(size.x, -size.y),
      Vector2(size.x + _horizontalRange, _verticalRange),
      Vector2(_horizontalRange, _verticalRange),
    ]);

    // TODO post-beta release check performance of isSolid.
    add(
      _hitbox = PolygonHitbox(_wallCornerPoints, isSolid: true)
        ..renderShape = DebugConstants.drawEntityCollisionBoxes
        ..paint = DebugConstants.transparentPaint,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    double runningX = 0;
    double runninyY = 0;
    for (int i = 0; i < _verticalRenders; i++) {
      _wallSprite.render(
        canvas,
        position: Vector2(runningX, runninyY - size.y),
        size: size,
        overridePaint: Paint()..color = Colors.white.withOpacity(1 - ((_verticalRenders - i) / 90.0)),
      );

      runningX += _horizontalDiffPerRender;
      runninyY += verticalDiffPerRender;
    }
  }

  void updateWallType(WallType wallType, {bool firstLoad = false}) {
    if (!firstLoad && _wallType == wallType) {
      return;
    }

    _wallType = wallType;
    _wallSprite = SpriteManager.getSprite('masonry/${wallType.name}-wall');
    scale = WallHelper.getScale(_wallType);
    _totalHealth = WallHelper.getDefaultTotalHealth(_wallType);
    _clearAndAddHitbox();

    if (!firstLoad) {
      // We need to re-render the snapshot, we ignore first load as we're not in the render loop yet.
      takeSnapshot();
    }
  }

  void reset() {
    updateWallType(WallType.wood);
    _health = _totalHealth;
    _hitbox?.collisionType = CollisionType.active;
    isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    _health -= damage;
    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      world.effectManager.addDamageText(damage, position);
    }

    if (_health <= MiscConstants.eps) {
      _hitbox?.collisionType = CollisionType.inactive;
    }
  }
}
