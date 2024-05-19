import 'dart:math';

import 'package:defend_your_flame/constants/misc_constants.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';

class MiscHelper {
  static double randomDouble({double minValue = 0, maxValue = 1}) {
    return GlobalVars.rand.nextDouble() * (maxValue - minValue) + minValue;
  }

  /// Returns a random element from a given list
  static T randomElement<T>(Iterable<T> list) {
    return list.elementAt(GlobalVars.rand.nextInt(list.length));
  }

  static randomChance({required int chance}) {
    return GlobalVars.rand.nextInt(100) < chance;
  }

  static bool doubleEquals(double a, double b) {
    return (a - b).abs() < MiscConstants.eps;
  }

  static bool doubleGreaterThanOrEquals(double a, double b) {
    return a > b || doubleEquals(a, b);
  }

  static bool doubleLessThanOrEquals(double a, double b) {
    return a < b || doubleEquals(a, b);
  }

  static double tapper(double input, {bool tapperLess = false}) {
    if (input <= 0) {
      return 1;
    }

    const double tapper = 0.6;
    // This is a tapper function that will make the spawn rate increase slower as the rounds progress
    // I tried sqrt but it was a bit too high of tappering
    return pow(input, tapperLess ? tapper * 1.1 : tapper).toDouble();
  }
}
