import 'package:defend_your_flame/helpers/global_vars.dart';

class MiscHelper {
  static double randomDouble({double minValue = 0, maxValue = 1}) {
    return GlobalVars.rand.nextDouble() * (maxValue - minValue) + minValue;
  }

  /// Returns a random element from a given list
  static T randomElement<T>(List<T> list) {
    return list[GlobalVars.rand.nextInt(list.length)];
  }
}
