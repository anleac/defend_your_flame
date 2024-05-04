import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TextManager {
  static const String _defaultFontFamily = "prstart";
  // static const String _boldFontFamily = "Metropolis-Bold";

  static final _defaultTextStyle =
      TextStyle(fontSize: 26.0, fontFamily: defaultFontFamily, color: ThemingConstants.defaultTextColour);

  static String get defaultFontFamily => _defaultFontFamily;
  static TextPaint get defaultRenderer => _defaultRenderer;

  static TextPaint get largeHeaderRenderer => _largeHeaderRenderer;

  static TextPaint get smallHeaderRenderer => _smallHeaderRenderer;
  static TextPaint get smallHeaderHoveredRenderer => _smallHeaderHoveredRenderer;
  static TextPaint get smallHeaderDisabledRenderer => _smallHeaderDisabledRenderer;

  static TextPaint get smallSubHeaderRenderer => _smallSubHeaderRenderer;

  static TextPaint get basicHudRenderer => _basicHudRenderer;
  static TextPaint get basicHudItalicRenderer => _basicHudItalicRenderer;
  static TextPaint get tinyRenderer => _tinyRenderer;

  static TextPaint get debugRenderer => _debugRenderer;

  static TextPaint customDefaultRenderer({double fontSize = 26, Color color = Colors.white, bool bold = false}) {
    return TextPaint(style: TextStyle(fontSize: fontSize, fontFamily: _defaultFontFamily, color: color));
  }

  static TextPaint copyWith(TextPaint paint, {Color? color, bool italic = false, bool bold = false}) {
    return TextPaint(
      style: paint.style.copyWith(
        color: color,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  static final TextPaint _defaultRenderer = TextPaint(style: _defaultTextStyle);

  static final TextPaint _largeHeaderRenderer = TextPaint(style: _defaultTextStyle.copyWith(fontSize: 36));

  static final TextPaint _smallHeaderRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: ThemingConstants.smallHeaderFontSize));

  static final TextPaint _smallHeaderHoveredRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: ThemingConstants.smallHeaderFontSize,
          color: ThemingConstants.defaultTextColour.darken(ThemingConstants.hoveredDarken)));

  static final TextPaint _smallHeaderDisabledRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: ThemingConstants.smallHeaderFontSize,
          color: ThemingConstants.defaultTextColour.darken(ThemingConstants.disabledDarken)));

  static final TextPaint _smallSubHeaderRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(fontSize: 16, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _basicHudRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(fontSize: 12, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _basicHudItalicRenderer = copyWith(_basicHudRenderer, italic: true);

  static final TextPaint _tinyRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(fontSize: 9, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _debugRenderer =
      TextPaint(style: TextStyle(fontSize: 18.0, fontFamily: defaultFontFamily, color: BasicPalette.red.color));

  // Return 3 TextPaints, one for each of the 3 states of a button, based off of the passed in textpaint
  static List<TextPaint> getButtonRenderers(TextPaint textPaint) {
    return [
      textPaint,
      copyWith(textPaint, color: textPaint.style.color!.darken(ThemingConstants.hoveredDarken)),
      copyWith(textPaint, color: textPaint.style.color!.darken(ThemingConstants.disabledDarken)),
    ];
  }
}
