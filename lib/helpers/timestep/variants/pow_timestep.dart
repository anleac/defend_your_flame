import 'dart:math';

import 'package:defend_your_flame/constants/timestep_constants.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_logic.dart';
import 'package:flame/game.dart';

class PowTimestep {
  static double _calculateRealMultiplier(double currentTimestep) {
    var (multiplier, remainderTimestep) = TimestepLogic.calculateConvertedTicks(currentTimestep);
    return (multiplier > 0 ? pow(TimestepConstants.desiredTimestep, multiplier) : 0) + remainderTimestep;
  }

  static double add(double value, double toAdd, double currentTimestep) =>
      TimestepLogic.add(value, toAdd, _calculateRealMultiplier(currentTimestep));

  static double multiply(double value, double toMultipleBy, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep);
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
