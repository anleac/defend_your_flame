import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:flame/components.dart';

class WallHelper {
  static Vector2 getScale(WallType type) {
    switch (type) {
      case WallType.barricade:
        return Vector2.all(0.63);
      case WallType.wood:
        return Vector2(0.35, 0.29);
      case WallType.stone:
        return Vector2(0.4, 0.34);
    }
  }

  static double getVerticalRendersPerDiff(WallType type) {
    if (type == WallType.barricade) {
      return 35;
    }

    return 30;
  }

  static Vector2 getWallSize(WallType type) {
    switch (type) {
      case WallType.barricade:
        return Vector2(75, 64);
      case WallType.wood:
        return Vector2(156, 398);
      case WallType.stone:
        return Vector2(156, 398);
    }
  }

  static int totalHealth(WallType type) {
    switch (type) {
      case WallType.barricade:
        return 80;
      case WallType.wood:
        return 120;
      case WallType.stone:
        return 160;
    }
  }

  static int defenseValue(WallType type) {
    switch (type) {
      case WallType.barricade:
        return 0;
      case WallType.wood:
        return 1;
      case WallType.stone:
        return 2;
    }
  }
}
