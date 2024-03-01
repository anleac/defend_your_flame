import 'dart:math';

import 'package:defend_your_flame/constants/timestep_constants.dart';

class TimestepLogic {
  static (int, double) calculateConvertedTicks(double currentTimestep) {
    var multiplier = (currentTimestep / TimestepConstants.desiredTimestep).floor();
    var remainderTimestep = currentTimestep % TimestepConstants.desiredTimestep;

    return (min(multiplier, TimestepConstants.maxFrameCatchup), remainderTimestep);
  }

  static double add(double value, double toAdd, double realTimestep) => value + (toAdd * realTimestep);

  static double multiply(double value, double toMultipleBy, double realTimestep) {
    var baseMultiplication = value * toMultipleBy;
    var delta = baseMultiplication - value;
    return value + (delta * realTimestep);
  }
}
