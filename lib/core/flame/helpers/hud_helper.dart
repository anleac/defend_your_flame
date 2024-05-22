import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/rendering.dart';

class HudHelper {
  static const double defaultHeaderHeight = 66;
  static const double defaultFooterHeight = 50;
  static const double defaultBodyHorizontalPadding = 20;

  static Rect createHeaderRectFrom(PositionComponent component) {
    return Rect.fromLTWH(
        component.topLeftPosition.x, component.topLeftPosition.y, component.size.x, defaultHeaderHeight);
  }

  static Rect createBodyRectFrom(PositionComponent component, {double padding = defaultBodyHorizontalPadding}) {
    return Rect.fromLTWH(component.topLeftPosition.x + padding, defaultHeaderHeight + component.topLeftPosition.y,
        component.size.x - (padding * 2), component.size.y - (defaultHeaderHeight + defaultFooterHeight));
  }

  static Rect createFooterRectFrom(PositionComponent component) {
    return Rect.fromLTWH(component.topLeftPosition.x,
        component.topLeftPosition.y + component.size.y - defaultFooterHeight, component.size.x, defaultFooterHeight);
  }

  static BorderedBackground borderedBackgroundFor(Rect component) {
    return BorderedBackground(hasFill: false)
      ..size = component.size.toVector2()
      ..position = component.center.toVector2()
      ..anchor = Anchor.center;
  }
}
