import 'dart:math';

import 'package:flame/extensions.dart';

class MathHelper {
  static double pi = 3.14159265359;

  static Vector2 getVelocity(double angle, double speed) => Vector2(speed * cos(angle), speed * sin(angle));

  static double findAngle(Vector2 position, Vector2 targetPosition) {
      var place = targetPosition - position;
      return atan2(place.y, place.x);
  }

  static double degreesToRads(double deg) {
    return (deg * pi) / 180.0;
  }

  static double radsToDegrees(double rad) {
    return (rad * 180.0) / pi;
  }

  static Vector2 rotateAboutOrigin(Vector2 point, Vector2 origin, double rotation) {
    var x = point.x - origin.x;
    var y = point.y - origin.y;
    var x2 = x * cos(rotation) - y * sin(rotation);
    var y2 = x * sin(rotation) + y * cos(rotation);
    return Vector2(x2 + origin.x, y2 + origin.y);
  }
}