// ignore_for_file: dead_code

import 'package:defend_your_flame/constants/constants.dart';

class DebugConstants {
  // Used for debugging if the timestep math is causing issues, in conjunction with the TimestepFaker.
  static const bool useFakeTimestep = false && Constants.debugBuild;
  static const int fakeFps = 30;

  static const bool drawEntityCollisionBoxes = false && Constants.debugBuild;
}
