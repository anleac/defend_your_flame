import 'dart:math';

import 'package:defend_your_flame/constants/timestep_constants.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_logic.dart';
import 'package:flame/game.dart';

class MathTimestep {
  static double _calculateRealMultiplier(double currentTimestep, {bool compoundMultiplier = false}) {
    var (multiplier, remainderTimestep) = TimestepLogic.calculateConvertedTicks(currentTimestep);

    // If we are wanting to catch up on missing frames, and we are in the context of a multiplication or division operation
    // we want to use the pow function to calculate the real multiplier.
    if (compoundMultiplier) {
      return (multiplier > 0 ? pow(TimestepConstants.desiredTimestep, multiplier) : 0) + remainderTimestep;
    }

    // Otherwise, if we're simply doing an add or subtract, we can just use the multiplier.
    return (TimestepConstants.desiredTimestep * multiplier) + remainderTimestep;
  }

  static double add(double value, double toAdd, double currentTimestep) =>
      TimestepLogic.add(value, toAdd, _calculateRealMultiplier(currentTimestep));

  static double multiply(double value, double toMultipleBy, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep, compoundMultiplier: true);
    return TimestepLogic.multiply(value, toMultipleBy, realTimestep);
  }

  static Vector2 multiplyVector2(Vector2 value, double toMultipleBy, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep);
    var newX = TimestepHelper.multiply(value.x, toMultipleBy, realTimestep);
    var newY = TimestepHelper.multiply(value.y, toMultipleBy, realTimestep);
    return Vector2(newX, newY);
  }

  static Vector2 addVector2(Vector2 value, Vector2 toAdd, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep);
    var newX = TimestepHelper.add(value.x, toAdd.x, realTimestep);
    var newY = TimestepHelper.add(value.y, toAdd.y, realTimestep);
    return Vector2(newX, newY);
  }
}
