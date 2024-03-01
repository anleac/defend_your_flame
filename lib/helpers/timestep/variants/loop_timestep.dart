import 'package:defend_your_flame/constants/timestep_constants.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_logic.dart';
import 'package:flame/components.dart';

class LoopTimestep {
  // This is less efficient but I have concerns about pow causing potential overflows, revert to using this
  // if we see any issues with pow.
  static T _loopOperation<T>(T Function(T value, double operationValue, double currentTimestep) operation, T value,
      double operationValue, double currentTimestep) {
    var (multiplier, remainderTimestep) = TimestepLogic.calculateConvertedTicks(currentTimestep);

    for (var i = 0; i < multiplier; i++) {
      value = operation(value, operationValue, TimestepConstants.desiredTimestep);
    }

    return operation(value, operationValue, remainderTimestep);
  }

  static double multiply(double value, double toMultipleBy, double currentTimestep) {
    return _loopOperation(TimestepHelper.multiply, value, toMultipleBy, currentTimestep);
  }

  static double add(double value, double toAdd, double currentTimestep) {
    return _loopOperation(TimestepHelper.add, value, toAdd, currentTimestep);
  }

  static Vector2 multiplyVector2(Vector2 value, double toMultipleBy, double currentTimestep) {
    var newX = TimestepHelper.multiply(value.x, toMultipleBy, currentTimestep);
    var newY = TimestepHelper.multiply(value.y, toMultipleBy, currentTimestep);
    return Vector2(newX, newY);
  }

  static Vector2 addVector2(Vector2 value, Vector2 toAdd, double currentTimestep) {
    var newX = TimestepHelper.add(value.x, toAdd.x, currentTimestep);
    var newY = TimestepHelper.add(value.y, toAdd.y, currentTimestep);
    return Vector2(newX, newY);
  }
}
