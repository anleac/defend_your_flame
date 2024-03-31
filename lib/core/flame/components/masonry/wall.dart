import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent with HasVisibility, Snapshot {
  late final double verticalRange;
  late Sprite _wallSprite;

  Wall({required double verticalRange}) : super(size: Vector2(156, 398)) {
    scale = Vector2.all(0.45);
    renderSnapshot = true;
    this.verticalRange = verticalRange / scale.y;
  }

  @override
  void onLoad() {
    super.onLoad();
    _wallSprite = SpriteManager.getSprite('masonry/stone-wall');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    const double verticalDiffPerRender = 18;
    final double iterations = (verticalRange / verticalDiffPerRender);
    final double horizontalRange = verticalRange / 7;
    final double horitontalDiffPerRender = horizontalRange / iterations;

    // Inverted because the anchor is bottom left.
    double runningX = -horizontalRange;
    double runninyY = -verticalRange;
    for (int i = 0; i < iterations; i++) {
      _wallSprite.render(
        canvas,
        position: Vector2(runningX, runninyY),
        size: size,
        overridePaint: Paint()..color = Colors.white.withOpacity(0.95 - ((iterations - i) / 90.0)),
      );

      runningX += horitontalDiffPerRender;
      runninyY += verticalDiffPerRender;
    }
  }
}
