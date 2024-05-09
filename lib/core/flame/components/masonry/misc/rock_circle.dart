import 'dart:math';

import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class RockCircle extends PositionComponent with Snapshot {
  // The amount of rock textures we have in our assets.
  // We are excluding the 6th rock for now.
  static const int rockTypes = 5;
  static const double rockPitScale = 1;
  static const double ovalWidth = 70 * rockPitScale;
  static const double ovalHeight = 27 * rockPitScale;

  static final Vector2 rockSize = Vector2(24, 24);

  late final List<Sprite> _rockSprites =
      List.generate(rockTypes, (index) => SpriteManager.getSprite('environment/rocks/rock${index + 1}'));

  RockCircle() {
    renderSnapshot = true;
    size = Vector2(ovalWidth, ovalHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const double rockScale = 0.66;
    final double totalScaleInfluence = (scale.x - 1) / 3 + 1;
    final int numRocks = (20 * rockPitScale * totalScaleInfluence).ceil();

    List<Vector2> rockPositions = [];
    for (int i = 0; i < numRocks; i++) {
      double angle = 2 * pi * i / numRocks;

      // Calculate the x and y coordinates using the equation of an ellipse
      double x = ovalWidth / 2 * cos(angle);
      double y = ovalHeight / 2 * sin(angle);

      rockPositions.add(Vector2(x, y));
    }

    rockPositions.sort((a, b) => a.y.compareTo(b.y));

    // Find the Y range, because there are negatives, then apply the horizontal displacement factor
    double yRange = (rockPositions.last.y - rockPositions.first.y) / 2;
    for (var rock in rockPositions) {
      rock.x += (rock.y + yRange) * ParallaxConstants.horizontalDisplacementFactor;
    }

    for (Vector2 rockPosition in rockPositions) {
      MiscHelper.randomElement(_rockSprites)
          .render(canvas, size: rockSize * rockScale, position: rockPosition + (size / 2), anchor: Anchor.center);
    }
  }
}
