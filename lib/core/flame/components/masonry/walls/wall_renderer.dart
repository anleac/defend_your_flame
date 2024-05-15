import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class WallRenderer extends PositionComponent with ParentIsA<Wall>, Snapshot {
  double _verticalRange = 0;
  double _horizontalRange = 0;
  double _verticalRenders = 0;
  double _horizontalDiffPerRender = 0;

  // Used to render the wall in the centered position based on the current wall width.
  double _xOffset = 0;

  late final double verticalRange;
  late Sprite _wallSprite;

  final List<Vector2> _wallCornerPoints = [];
  final List<Rect> _localSolidBoxes = [];
  final List<Rect> _absoluteSolidBoxes = [];

  List<Vector2> get wallCornerPoints => _wallCornerPoints;
  List<Rect> get solidBoxes => _absoluteSolidBoxes;

  double get _verticalDiffPerRender => WallHelper.getVerticalRendersPerDiff(parent.wallType);

  WallRenderer({required this.verticalRange}) {
    renderSnapshot = true;
  }

  _updateRenderValues() {
    _verticalRange = verticalRange / parent.scale.y;
    _verticalRenders = (_verticalRange / _verticalDiffPerRender).ceilToDouble();

    _horizontalRange = _verticalRange * ParallaxConstants.horizontalDisplacementFactor;
    _horizontalDiffPerRender = _horizontalRange / _verticalRenders;

    _xOffset = -25 - (parent.scaledSize.x - Wall.wallAreaWidth);
  }

  updateWallRenderValues() {
    var wallType = parent.wallType;
    _wallSprite = SpriteManager.getSprite('masonry/${wallType.name}-wall');

    _updateRenderValues();
    _wallCornerPoints.clear();
    _wallCornerPoints.addAll([
      Vector2(_xOffset, -size.y),
      Vector2(size.x + _xOffset, -size.y),
      Vector2(size.x + _xOffset + _horizontalRange, _verticalRange),
      Vector2(_horizontalRange + _xOffset, _verticalRange),
    ]);

    _localSolidBoxes.clear();

    double runningX = 0;
    double runninyY = 0;
    for (int i = 0; i < _verticalRenders; i++) {
      _localSolidBoxes.add(
        Rect.fromPoints(
          Offset(runningX + _xOffset, runninyY - size.y),
          Offset(runningX + _xOffset + size.x, runninyY),
        ),
      );

      runningX += _horizontalDiffPerRender;
      runninyY += _verticalDiffPerRender;
    }

    _absoluteSolidBoxes.clear();
    _absoluteSolidBoxes.addAll(_localSolidBoxes.map((box) {
      // We need to scale it, and add the parent's position.
      return Rect.fromLTWH(
        box.left * parent.scale.x + parent.absoluteTopLeftPosition.x,
        box.top * parent.scale.y + parent.absoluteTopLeftPosition.y,
        box.width * parent.scale.x,
        box.height * parent.scale.y,
      );
    }));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    for (var solidBox in _localSolidBoxes) {
      _wallSprite.render(canvas, position: solidBox.topLeft.toVector2(), size: solidBox.size.toVector2());
    }
  }

  void renderWallType({bool firstLoad = false}) {
    if (!firstLoad) {
      // We need to re-render the snapshot, we ignore first load as we're not in the render loop yet.
      takeSnapshot();
    }
  }
}
