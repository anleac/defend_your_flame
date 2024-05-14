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
}
