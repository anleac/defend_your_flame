// ignore_for_file: dead_code

import 'package:defend_your_flame/constants/constants.dart';
import 'package:flutter/material.dart';

class DebugConstants {
  // Used for debugging if the timestep math is causing issues, in conjunction with the TimestepFaker.
  static const bool useFakeTimestep = false && Constants.debugBuild;
  static const int fakeFps = 30;

  static const bool drawEntityCollisionBoxes = false && Constants.debugBuild;
  static const bool drawWallCollisionBoxes = false && Constants.debugBuild;
  static const bool drawWallBoundaryBox = false && Constants.debugBuild;
  static const bool drawBaseArea = false && Constants.debugBuild;

  static final Paint transparentPaint = Paint()..color = const Color.fromARGB(100, 255, 80, 80);

  static final Paint faintDebugPaint = Paint()
    ..color = Colors.red.withAlpha(90)
    ..style = PaintingStyle.fill;

  static final Paint debugPaint = Paint()
    ..color = Colors.red.withAlpha(120)
    ..style = PaintingStyle.fill;

  static final Paint darkDebugPaint = Paint()
    ..color = Colors.black.withAlpha(180)
    ..style = PaintingStyle.fill;

  // Setting this to true gives you max gold and sets the shop immediately avaliable.
  static const bool testShopLogic = true && Constants.debugBuild;

  static const bool superPoweredTotems = false && Constants.debugBuild;
}
