// This timestep engine is very naive, and just a simple buffer to give a better experience across devices.
// There are huge limitations, as these catch up timesteps will always be run in isolation of object modifications and therefore
// may break physic collisions etc, one such example would be a large catchup on a fast item may pass through an object.

import 'package:defend_your_flame/constants/timestep_constants.dart';
import 'package:defend_your_flame/helpers/timestep/variants/loop_timestep.dart';
import 'package:defend_your_flame/helpers/timestep/variants/math_timestep.dart';
import 'package:flame/game.dart';

class TimestepHelper {
  static double multiply(double value, double toMultipleBy, double currentTimestep) {
    if (TimestepConstants.isPowVariant) {
      return MathTimestep.multiply(value, toMultipleBy, currentTimestep);
    } else {
      return LoopTimestep.multiply(value, toMultipleBy, currentTimestep);
    }
  }

  static double add(double value, double toAdd, double currentTimestep) {
    if (TimestepConstants.isPowVariant) {
      return MathTimestep.add(value, toAdd, currentTimestep);
    } else {
      return LoopTimestep.add(value, toAdd, currentTimestep);
    }
  }

  static Vector2 multiplyVector2(Vector2 value, double toMultipleBy, double currentTimestep) {
    if (TimestepConstants.isPowVariant) {
      return MathTimestep.multiplyVector2(value, toMultipleBy, currentTimestep);
    } else {
      return LoopTimestep.multiplyVector2(value, toMultipleBy, currentTimestep);
    }
  }

  static Vector2 addVector2(Vector2 value, Vector2 toAdd, double currentTimestep) {
    if (TimestepConstants.isPowVariant) {
      return MathTimestep.addVector2(value, toAdd, currentTimestep);
    } else {
      return LoopTimestep.addVector2(value, toAdd, currentTimestep);
    }
  }
}
