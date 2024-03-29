import 'package:flutter/foundation.dart';

class Constants {
  static const String gameTitle = 'Defend Your Flame';

  static const bool debugBuild = kDebugMode; // Add || true if you want to force debug mode

  static const desireAspectRatio = 16 / 9;
  static const desiredWidth = 1100.0;
  static const desiredHeight = desiredWidth / desireAspectRatio;

  static const double eps = 0.0001;
}
