import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_renderer.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Wall extends PositionComponent with HasVisibility, HasWorldReference<MainWorld> {
  // The offset from the bottom of the wall to the bottom of the base
  static const double wallOffsetFromGround = 10;
  static const double wallAreaWidth = 70;

  static const double verticalRange = PlayerBase.baseHeight - wallOffsetFromGround * 2;

  late final WallRenderer _wallRenderer = WallRenderer(verticalRange: verticalRange)..size = size;

  WallType _wallType = WallType.barricade;

  // Wall stats that need to be carefully reset when upgrading the wall, loading a save game, restarting game, etc.
  // To make this less error prone, we centralize this logic in `_setWallStats`
  late int _totalHealth;
  late int _health;
  late int _defenseValue;

  PolygonHitbox? _hitbox;

  WallType get wallType => _wallType;
  int get health => _health < 0 ? 0 : _health;
  int get totalHealth => _totalHealth;
  int get defenseValue => _defenseValue;

  Vector2 get wallCenter => center;

  Wall() {
    _setWallStats();
  }

  _setWallStats({bool resetHealth = true}) {
    // Needed simply for rendering, not logic, but changes based on wall type.
    size = WallHelper.getWallSize(_wallType);
    scale = WallHelper.getScale(_wallType);
    _wallRenderer.size = size;

    _totalHealth = WallHelper.totalHealth(_wallType);
    _defenseValue = WallHelper.defenseValue(_wallType);

    if (resetHealth) {
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
    _hitbox?.removeFromParent();
    _wallRenderer.updateWallRenderValues();

    // TODO post-beta release check performance of isSolid.
    add(
      _hitbox = PolygonHitbox(_wallRenderer.wallCornerPoints, isSolid: true)
        ..renderShape = DebugConstants.drawEntityCollisionBoxes
        ..paint = DebugConstants.transparentPaint,
    );
  }

  void updateWallType(WallType wallType, {bool firstLoad = false, bool resetHealth = false}) {
    if (!firstLoad && _wallType == wallType) {
      return;
    }

    _wallType = wallType;

    var newTotalHealth = WallHelper.totalHealth(_wallType);
    if (_totalHealth != newTotalHealth && newTotalHealth > _totalHealth) {
      _health += newTotalHealth - _totalHealth;
    }

    _setWallStats(resetHealth: resetHealth);

    _clearAndAddHitbox();
    _wallRenderer.renderWallType(firstLoad: firstLoad);
  }

  void reset() {
    updateWallType(WallType.wood, resetHealth: true);

    _hitbox?.collisionType = CollisionType.active;
    isVisible = true;
  }

  void takeDamage(int damage, {Vector2? position}) {
    var trueDamage = damage - _defenseValue;
    _health -= trueDamage;

    if (position != null) {
      // If we have a valid damage position, then add a damage text effect.
      world.effectManager.addDamageText(trueDamage, position);
    }

    if (_health <= MiscConstants.eps) {
      _hitbox?.collisionType = CollisionType.inactive;
    }
  }
}
