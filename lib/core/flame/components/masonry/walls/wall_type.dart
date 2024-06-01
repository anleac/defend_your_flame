import 'package:flame/components.dart';

enum WallType { barricade, wood, stone }

extension WallTypeExtension on WallType {
  Vector2 get scale {
    switch (this) {
      case WallType.barricade:
        return Vector2.all(0.63);
      case WallType.wood:
        return Vector2(0.35, 0.29);
      case WallType.stone:
        return Vector2(0.38, 0.33);
    }
  }

  double get verticalRendersPerDiff {
    if (this == WallType.barricade) {
      return 35;
    }

    return 30;
  }

  Vector2 get wallSize {
    switch (this) {
      case WallType.barricade:
        return Vector2(75, 64);
      case WallType.wood:
        return Vector2(156, 398);
      case WallType.stone:
        return Vector2(178, 398);
    }
  }

  int get totalHealth {
    switch (this) {
      case WallType.barricade:
        return 80;
      case WallType.wood:
        return 130;
      case WallType.stone:
        return 200;
    }
  }

  int get defenseValue {
    switch (this) {
      case WallType.barricade:
        return 0;
      case WallType.wood:
        return 1;
      case WallType.stone:
        return 2;
    }
  }
}
