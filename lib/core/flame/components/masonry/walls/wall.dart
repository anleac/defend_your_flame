import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_renderer.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Wall extends PositionComponent with HasVisibility, HasWorldReference<MainWorld> {
  late final WallRenderer _wallRenderer = WallRenderer(verticalRange: verticalRange)..size = size;
  final double verticalRange;

  WallType _wallType = WallType.wood;
  late int _totalHealth = WallHelper.getDefaultTotalHealth(_wallType);
  int _health = 100;

  PolygonHitbox? _hitbox;

  WallType get wallType => _wallType;
  int get health => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;

  Vector2 get wallCenter => center;

  Wall({required this.verticalRange}) : super(size: Vector2(156, 398)) {
    scale = WallHelper.getScale(_wallType);
  }

  @override
  void onLoad() {
    super.onLoad();
    add(_wallRenderer);

    updateWallType(_wallType, firstLoad: true);
  }

  _clearAndAddHitbox() {
    _hitbox?.removeFromParent();
    _wallRenderer.updateWallRenderValues();

    // TODO post-beta release check performance of isSolid.
    add(
      _hitbox = PolygonHitbox(_wallRenderer.wallCornerPoints, isSolid: true)
        ..renderShape = DebugConstants.drawEntityCollisionBoxes
        ..paint = DebugConstants.transparentPaint,
    );
  }

  void updateWallType(WallType wallType, {bool firstLoad = false}) {
    if (!firstLoad && _wallType == wallType) {
      return;
    }

    _wallType = wallType;
    scale = WallHelper.getScale(_wallType);
    var newTotalHealth = WallHelper.getDefaultTotalHealth(_wallType);

    if (_totalHealth != newTotalHealth && newTotalHealth > _totalHealth) {
      // Add the difference to the health.
      _health += newTotalHealth - _totalHealth;
    }

    _totalHealth = newTotalHealth;

    _clearAndAddHitbox();
    _wallRenderer.renderWallType(firstLoad: firstLoad);
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
