class TimestepConstants {
  static const int desiredFps = 60;
  static const double desiredTimestep = 1.0 / desiredFps;

  // How many frames we want to catch up on if we fall behind at the most.
  // Arbitrary set it to a half a second worth of ticks.
  static const int maxFrameCatchup = 30;
}
