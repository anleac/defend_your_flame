import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent with HasVisibility, HasWorldReference<MainWorld>, Snapshot {
  late final double verticalRange;
  late Sprite _wallSprite;

  WallType _wallType = WallType.wood;
  late int _totalHealth = WallHelper.getDefaultTotalHealth(_wallType);
  int _health = 100;

  WallType get wallType => _wallType;
  int get health => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;

  Wall({required this.verticalRange}) : super(size: Vector2(156, 398)) {
    scale = WallHelper.getScale(_wallType);
    renderSnapshot = true;
  }

  @override
  void onLoad() {
    super.onLoad();

    updateWallType(_wallType, firstLoad: true);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const double verticalDiffPerRender = 30;
    final double scaledVerticalRange = verticalRange / scale.y;
    final double iterations = (scaledVerticalRange / verticalDiffPerRender).ceilToDouble();
    final double horizontalRange = scaledVerticalRange / 12;
    final double horitontalDiffPerRender = horizontalRange / iterations;

    double runningX = 0;
    double runninyY = 0;
    for (int i = 0; i < iterations; i++) {
      _wallSprite.render(
        canvas,
        position: Vector2(runningX, runninyY) - size,
        size: size,
        overridePaint: Paint()..color = Colors.white.withOpacity(1 - ((iterations - i) / 90.0)),
      );

      runningX += horitontalDiffPerRender;
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

    if (!firstLoad) {
      // We need to re-render the snapshot, we ignore first load as we're not in the render loop yet.
      takeSnapshot();
    }
  }

  void reset() {
    updateWallType(WallType.wood);
    _health = _totalHealth;
    isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    _health -= damage;
    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      world.effectManager.addDamageText(damage, position);
    }
  }
}
