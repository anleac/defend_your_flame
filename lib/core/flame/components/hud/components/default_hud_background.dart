import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/helpers/hud_helper.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DefaultHudBackground extends PositionComponent with HasWorldReference<MainWorld> {
  late final BorderedBackground _background = BorderedBackground()..size = super.size;

  late final Rect _headerRect =
      HudHelper.createHeaderRectFrom(_background).translate(topLeftPosition.x, topLeftPosition.y);
  late final Rect _bodyRect = HudHelper.createBodyRectFrom(_background).translate(topLeftPosition.x, topLeftPosition.y);
  late final Rect _footerRect =
      HudHelper.createFooterRectFrom(_background).translate(topLeftPosition.x, topLeftPosition.y);

  late final BorderedBackground _bodyBackground =
      HudHelper.borderedBackgroundFor(_bodyRect.translate(-topLeftPosition.x, -topLeftPosition.y));

  Rect get headerRect => _headerRect;
  Rect get bodyRect => _bodyRect;
  Rect get footerRect => _footerRect;

  DefaultHudBackground({required MainWorld world, double sizeFactor = 1}) {
    super.size = Vector2(world.worldWidth / (1.2 / sizeFactor), world.worldHeight / (1.2 / sizeFactor));
    super.position = Vector2(world.worldWidth / 2, world.worldHeight / 2);
    super.anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_bodyBackground);

    return super.onLoad();
  }
}
