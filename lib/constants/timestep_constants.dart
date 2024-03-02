import 'package:defend_your_flame/helpers/timestep/timestep_variant.dart';

class TimestepConstants {
  static const int desiredFps = 60;
  static const double desiredTimestep = 1.0 / desiredFps;

  // How many frames we want to catch up on if we fall behind at the most.
  // Arbitrary set it to a half a second worth of ticks.
  static const int maxFrameCatchup = 30;

  static const TimestepVariant variant = TimestepVariant.math;

  static bool get isPowVariant => variant == TimestepVariant.math;
  static bool get isLoopVariant => variant == TimestepVariant.loop;
}
