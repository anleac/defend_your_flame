import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:flame/components.dart';

class WallHelper {
  static Vector2 getScale(WallType type) {
    switch (type) {
      case WallType.wood:
        return Vector2(0.35, 0.26);
      case WallType.stone:
        return Vector2(0.4, 0.26);
    }
  }
}
