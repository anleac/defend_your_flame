// This timestep engine is very naive, and just a simple buffer to give a better experience across devices.
// There are huge limitations, as these catch up timesteps will always be run in isolation of object modifications and therefore
// may break physic collisions etc, one such example would be a large catchup on a fast item may pass through an object.
import 'dart:math';

import 'package:defend_your_flame/constants/timestep_constants.dart';
import 'package:flame/game.dart';

class TimestepHelper {
  static (int, double) _calculateConvertedTicks(double currentTimestep) {
    var multiplier = (currentTimestep / TimestepConstants.desiredTimestep).floor();
    var remainderTimestep = currentTimestep % TimestepConstants.desiredTimestep;

    return (min(multiplier, TimestepConstants.maxFrameCatchup), remainderTimestep);
  }

  static double _calculateRealMultiplier(double currentTimestep) {
    var (multiplier, remainderTimestep) = _calculateConvertedTicks(currentTimestep);
    return (multiplier > 0 ? pow(TimestepConstants.desiredTimestep, multiplier) : 0) + remainderTimestep;
  }

  static double multiply(double value, double toMultipleBy, double currentTimestep) =>
      _multiply(value, toMultipleBy, _calculateRealMultiplier(currentTimestep));

  static double _multiply(double value, double toMultipleBy, double realTimestep) {
    var baseMultiplication = value * toMultipleBy;
    var delta = baseMultiplication - value;
    return value + (delta * realTimestep);
  }

  static double add(double value, double toAdd, double currentTimestep) =>
      _add(value, toAdd, _calculateRealMultiplier(currentTimestep));

  static double _add(double value, double toAdd, double realTimestep) => value + (toAdd * realTimestep);

  static Vector2 multiplyVector2(Vector2 value, double toMultipleBy, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep);
    var newX = _multiply(value.x, toMultipleBy, realTimestep);
    var newY = _multiply(value.y, toMultipleBy, realTimestep);
    return Vector2(newX, newY);
  }

  static Vector2 addVector2(Vector2 value, Vector2 toAdd, double currentTimestep) {
    var realTimestep = _calculateRealMultiplier(currentTimestep);
    var newX = _add(value.x, toAdd.x, realTimestep);
    var newY = _add(value.y, toAdd.y, realTimestep);
    return Vector2(newX, newY);
  }

  // Unused PoC I was exploring with instead of using `pow` to calculate the multiplier.
  // This is less efficient but I have concerns about pow causing potential overflows, revert to using this
  // if we see any issues with pow.
  // ignore: unused_element
  static T _loopOperation<T>(T Function(T value, double operationValue, double currentTimestep) operation, T value,
      double operationValue, double currentTimestep) {
    var (multiplier, remainderTimestep) = _calculateConvertedTicks(currentTimestep);

    for (var i = 0; i < multiplier; i++) {
      value = operation(value, operationValue, TimestepConstants.desiredTimestep);
    }

    return operation(value, operationValue, remainderTimestep);
  }

  /*
  static double multiply(double value, double toMultipleBy, double currentTimestep) {
    return _loopOperation(_multiply, value, toMultipleBy, currentTimestep);
  }

  static double add(double value, double toAdd, double currentTimestep) {
    return _loopOperation(_add, value, toAdd, currentTimestep);
  }
  */
}
