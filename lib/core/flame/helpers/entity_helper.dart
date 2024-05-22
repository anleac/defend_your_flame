import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class EntityHelper {
  static CircleHitbox createCircleHitbox({
    required double radius,
    Vector2? position,
    CollisionType collisionType = CollisionType.passive,
    bool isSolid = false,
  }) {
    final hitbox = CircleHitbox(
      position: position,
      radius: radius,
      collisionType: collisionType,
    )..isSolid = isSolid;

    if (DebugConstants.drawEntityCollisionBoxes) {
      hitbox.renderShape = true;
      hitbox.paint = ThemingConstants.transparentPaint;
    }

    return hitbox;
  }

  static RectangleHitbox createRectangleHitbox({
    required Vector2 size,
    Vector2? position,
    Anchor anchor = Anchor.center,
    CollisionType collisionType = CollisionType.passive,
    bool isSolid = false,
  }) {
    final hitbox = RectangleHitbox(
      position: position,
      size: size,
      anchor: anchor,
      collisionType: collisionType,
    )..isSolid = isSolid;

    if (DebugConstants.drawEntityCollisionBoxes) {
      hitbox.renderShape = true;
      hitbox.paint = ThemingConstants.transparentPaint;
    }

    return hitbox;
  }

  static void drawHealthBar(Canvas canvas,
      {required Entity entity, required double width, required Vector2 centerPosition}) {
    if (!entity.isAlive) {
      return;
    }

    const healthBarHeight = 2.0;
    const healthBarWidthOffset = 2;
    const healthBarHeightOffset = 3;
    final healthBarWidth = width + (healthBarWidthOffset * 2);

    final healthBarRect = Rect.fromCenter(
        center: Offset(centerPosition.x, centerPosition.y - healthBarHeight - healthBarHeightOffset),
        width: healthBarWidth,
        height: healthBarHeight);

    final healthBarBackgroundPaint = Paint()
      ..color = const Color.fromARGB(150, 66, 0, 0)
      ..style = PaintingStyle.fill;

    final healthBarBackgroundRect =
        Rect.fromLTWH(healthBarRect.left, healthBarRect.top, healthBarWidth, healthBarHeight);

    canvas.drawRect(healthBarBackgroundRect, healthBarBackgroundPaint);

    final healthBarFillPaint = Paint()
      ..color = const Color.fromARGB(150, 228, 0, 0)
      ..style = PaintingStyle.fill;

    final healthBarFillRect = Rect.fromLTWH(healthBarRect.left, healthBarRect.top,
        healthBarWidth * entity.currentHealth / entity.totalHealth, healthBarHeight);

    canvas.drawRect(healthBarFillRect, healthBarFillPaint);
  }
}
