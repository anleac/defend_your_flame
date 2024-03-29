import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TextManager {
  static const String _defaultFontFamily = "prstart";
  // static const String _boldFontFamily = "Metropolis-Bold";

  static final _defaultColor = BasicPalette.white.color;
  static final _defaultTextStyle = TextStyle(fontSize: 26.0, fontFamily: defaultFontFamily, color: _defaultColor);

  static String get defaultFontFamily => _defaultFontFamily;
  static TextRenderer get defaultRenderer => _defaultRenderer;

  static TextRenderer get largeHeaderRenderer => _largeHeaderRenderer;

  static TextRenderer get smallHeaderRenderer => _smallHeaderRenderer;
  static TextRenderer get smallHeaderHoveredRenderer => _smallHeaderHoveredRenderer;
  static TextRenderer get smallHeaderDisabledRenderer => _smallHeaderDisabledRenderer;

  static TextRenderer get smallSubHeaderRenderer => _smallSubHeaderRenderer;

  static TextRenderer get basicHudRenderer => _basicHudRenderer;
  static TextRenderer get tinyRenderer => _tinyRenderer;

  static TextRenderer get debugRenderer => _debugRenderer;

  static TextRenderer customDefaultRenderer({double fontSize = 26, Color color = Colors.white, bool bold = false}) {
    return TextPaint(style: TextStyle(fontSize: fontSize, fontFamily: _defaultFontFamily, color: color));
  }

  static final TextRenderer _defaultRenderer = TextPaint(style: _defaultTextStyle);

  static final TextRenderer _largeHeaderRenderer = TextPaint(style: _defaultTextStyle.copyWith(fontSize: 36));

  static final TextRenderer _smallHeaderRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: ThemingConstants.smallHeaderFontSize));
  static final TextRenderer _smallHeaderHoveredRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: ThemingConstants.smallHeaderFontSize, color: _defaultColor.darken(ThemingConstants.hoveredDarken)));
  static final TextRenderer _smallHeaderDisabledRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: ThemingConstants.smallHeaderFontSize,
          color: _defaultColor.darken(ThemingConstants.disabledDarken)));

  static final TextRenderer _smallSubHeaderRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: 16, color: _defaultColor.withOpacity(0.92)));
  static final TextRenderer _basicHudRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: 12, color: _defaultColor.withOpacity(0.92)));

  static final TextRenderer _tinyRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: 9, color: _defaultColor.withOpacity(0.92)));

  static final TextRenderer _debugRenderer =
      TextPaint(style: TextStyle(fontSize: 18.0, fontFamily: defaultFontFamily, color: BasicPalette.red.color));
} 
