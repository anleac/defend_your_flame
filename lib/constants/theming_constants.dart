import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';

class ThemingConstants {
  static const String comingSoonIndicator = '(soon)';

  static const double hoveredDarken = 0.2;
  static const double disabledDarken = 0.26;

  static final Vector2 _menuButtonGap = Vector2(0, 65);
  static Vector2 get menuButtonGap => _menuButtonGap;

  static const Color borderColour = Color(0xFF808080);

  static const Color defaultTextColour = Colors.white;
  static const Color purchasedItemColour = Color(0xFF00FF00);
  static const Color cantAffordColour = Color.fromARGB(255, 255, 50, 50);

  static const Color disabledTint = Color.fromARGB(100, 61, 61, 61);

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
}
