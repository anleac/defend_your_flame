import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class WallRenderer extends PositionComponent with ParentIsA<Wall>, Snapshot {
  static const double verticalDiffPerRender = 30;

  double _verticalRange = 0;
  double _horizontalRange = 0;
  double _verticalRenders = 0;
  double _horizontalDiffPerRender = 0;

  late final double verticalRange;
  late Sprite _wallSprite;

  final List<Vector2> _wallCornerPoints = [];

  List<Vector2> get wallCornerPoints => _wallCornerPoints;

  WallRenderer({required this.verticalRange}) {
    renderSnapshot = true;
  }

  _updateRenderValues() {
    _verticalRange = verticalRange / parent.scale.y;
    _verticalRenders = (_verticalRange / verticalDiffPerRender).ceilToDouble();

    _horizontalRange = _verticalRange * ParallaxConstants.horizontalDisplacementFactor;
    _horizontalDiffPerRender = _horizontalRange / _verticalRenders;
  }

  updateWallRenderValues() {
    var wallType = parent.wallType;
    _wallSprite = SpriteManager.getSprite('masonry/${wallType.name}-wall');

    _updateRenderValues();
    _wallCornerPoints.clear();
    _wallCornerPoints.addAll([
      Vector2(0, -size.y),
      Vector2(size.x, -size.y),
      Vector2(size.x + _horizontalRange, _verticalRange),
      Vector2(_horizontalRange, _verticalRange),
    ]);
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

  void renderWallType({bool firstLoad = false}) {
    if (!firstLoad) {
      // We need to re-render the snapshot, we ignore first load as we're not in the render loop yet.
      takeSnapshot();
    }
  }
}
