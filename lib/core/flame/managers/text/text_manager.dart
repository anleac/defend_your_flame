import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TextManager {
  static const double defaultLargeFontSize = defaultFontSize * 1.5;
  static const double smallHeaderFontSize = defaultFontSize * 1.2;
  static const double defaultFontSize = 18;
  static const double defaultMediumFontSize = defaultFontSize * 0.9;
  static const double defaultSmallFontSize = defaultFontSize * 0.8;
  static const double defaultTinyFontSize = defaultFontSize * 0.6;

  static const String _defaultFontFamily = "Monocraft";
  static const String _titleFontFamily = "prstart";

  static const TextStyle _defaultTextStyle =
      TextStyle(fontSize: defaultFontSize, fontFamily: _defaultFontFamily, color: ThemingConstants.defaultTextColour);

  static String get defaultFontFamily => _defaultFontFamily;
  static TextPaint get defaultRenderer => _defaultRenderer;

  static TextPaint get largeHeaderRenderer => _largeHeaderRenderer;

  static TextPaint get headerRenderer => _headerRenderer;
  static TextPaint get smallHeaderRenderer => _smallHeaderRenderer;
  static TextPaint get smallHeaderHoveredRenderer => _smallHeaderHoveredRenderer;
  static TextPaint get smallHeaderDisabledRenderer => _smallHeaderDisabledRenderer;

  static TextPaint get smallSubHeaderRenderer => _smallSubHeaderRenderer;
  static TextPaint get smallSubHeaderBoldRenderer => copyWith(_smallSubHeaderRenderer, bold: true);

  static TextPaint get basicHudRenderer => _basicHudRenderer;
  static TextPaint get basicHudBoldRenderer => _basicHudBoldRenderer;
  static TextPaint get basicHudItalicRenderer => _basicHudItalicRenderer;
  static TextPaint get tinyRenderer => _tinyRenderer;

  static TextPaint get debugRenderer => _debugRenderer;

  static TextPaint customDefaultRenderer(
      {double fontSize = defaultLargeFontSize, Color color = Colors.white, bool bold = false}) {
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

  static final TextPaint _largeHeaderRenderer = TextPaint(
      style: const TextStyle(fontSize: 36, fontFamily: _titleFontFamily, color: ThemingConstants.defaultTextColour));

  static final TextPaint _headerRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(fontSize: defaultLargeFontSize, color: ThemingConstants.defaultTextColour));

  static final TextPaint _smallHeaderRenderer =
      TextPaint(style: _defaultTextStyle.copyWith(fontSize: smallHeaderFontSize));

  static final TextPaint _smallHeaderHoveredRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: smallHeaderFontSize,
          color: ThemingConstants.defaultTextColour.darken(ThemingConstants.hoveredDarken)));

  static final TextPaint _smallHeaderDisabledRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: smallHeaderFontSize,
          color: ThemingConstants.defaultTextColour.darken(ThemingConstants.disabledDarken)));

  static final TextPaint _smallSubHeaderRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: defaultMediumFontSize, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _basicHudRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: defaultSmallFontSize, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _basicHudBoldRenderer = copyWith(_basicHudRenderer, bold: true);

  static final TextPaint _basicHudItalicRenderer = copyWith(_basicHudRenderer, italic: true);

  static final TextPaint _tinyRenderer = TextPaint(
      style: _defaultTextStyle.copyWith(
          fontSize: defaultTinyFontSize, color: ThemingConstants.defaultTextColour.withOpacity(0.92)));

  static final TextPaint _debugRenderer = TextPaint(
      style: TextStyle(fontSize: defaultSmallFontSize, fontFamily: defaultFontFamily, color: BasicPalette.red.color));

  // Return 3 TextPaints, one for each of the 3 states of a button, based off of the passed in textpaint
  static List<TextPaint> getButtonRenderers(TextPaint textPaint) {
    return [
      textPaint,
      copyWith(textPaint, color: textPaint.style.color!.darken(ThemingConstants.hoveredDarken)),
      copyWith(textPaint, color: textPaint.style.color!.darken(ThemingConstants.disabledDarken)),
    ];
  }
}
