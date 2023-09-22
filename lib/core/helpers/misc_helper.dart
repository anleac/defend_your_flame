import 'dart:math';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/helpers/global_vars.dart';
import 'package:flame/components.dart';

class MiscHelper {
  // `dt` is the time between each frame, this lets us scale the operations
  // incase of frame delay (or even differing frame rates between devices)
  static double dtToScale(double dt) {
    var scale = dt / Constants.desiredUdt;
    if (scale > Constants.maxFrameCatchup) {
      scale = Constants.maxFrameCatchup;
    }

    return dt * scale;
  }

  static double randomDouble({double minValue = 0, maxValue = 1}) {
    return GlobalVars.rand.nextDouble() * (maxValue - minValue) + minValue;
  }

  // Use this if you need to scale a multiplication
  static num doubleToDtScaleMult(double dt, double val) {
    var scale = dt / Constants.desiredUdt;

    if (scale > Constants.maxFrameCatchup) {
      scale = Constants.maxFrameCatchup;
    }

    return pow(val, scale);
  }

  static Vector2 vectorToDtScale(double dt, Vector2 val) {
    var scale = dt / Constants.desiredUdt;

    if (scale > Constants.maxFrameCatchup) {
      scale = Constants.maxFrameCatchup;
    }

    return val * scale;
  }

  /// Returns a random element from a given list
  static T randomElement<T>(List<T> list) {
    return list[GlobalVars.rand.nextInt(list.length)];
  }
}
