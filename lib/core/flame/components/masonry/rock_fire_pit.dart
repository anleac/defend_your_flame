import 'dart:math';

import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class RockFirePit extends PositionComponent with Snapshot {
  // The amount of rock textures we have in our assets.
  static const int rockTypes = 6;
  static const double ovalWidth = 60;
  static const double ovalHeight = 20;

  late final List<Sprite> _rockSprites =
      List.generate(rockTypes, (index) => SpriteManager.getSprite('environment/rocks/rock${index + 1}'));

  RockFirePit() {
    renderSnapshot = true;
    size = Vector2(ovalWidth, ovalHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const int numRocks = 20;

    // Create a list of rocks with their positions
    List<Vector2> rocks = [];
    for (int i = 0; i < numRocks; i++) {
      // Calculate the angle for this rock
      double angle = 2 * pi * i / numRocks;

      // Calculate the x and y coordinates using the equation of an ellipse
      double x = ovalWidth / 2 * cos(angle);
      double y = ovalHeight / 2 * sin(angle);

      rocks.add(Vector2(x, y));
    }

    rocks.sort((a, b) => a.y.compareTo(b.y));

    for (Vector2 rock in rocks) {
      MiscHelper.randomElement(_rockSprites).render(canvas, position: rock);
    }
  }
}
