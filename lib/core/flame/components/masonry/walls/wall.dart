import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent with HasVisibility, Snapshot {
  late final double verticalRange;
  late Sprite _wallSprite;

  WallType _wallType = WallType.wood;

  Wall({required double verticalRange}) : super(size: Vector2(156, 398)) {
    scale = WallHelper.getScale(_wallType);
    renderSnapshot = true;
    this.verticalRange = verticalRange / scale.y;
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
    final double iterations = (verticalRange / verticalDiffPerRender).ceilToDouble();
    final double horizontalRange = verticalRange / 6;
    final double horitontalDiffPerRender = horizontalRange / iterations;

    // Inverted because the anchor is bottom left.
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

    if (!firstLoad) {
      // We need to re-render the snapshot, we ignore first load as we're not in the render loop yet.
      takeSnapshot();
    }
  }
}
