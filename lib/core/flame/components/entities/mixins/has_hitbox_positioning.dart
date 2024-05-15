import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

mixin HasHitboxPositioning on PositionComponent {
  Iterable<ShapeHitbox> get hitboxes => children.query<ShapeHitbox>();

  @override
  @mustCallSuper
  Future<void> onLoad() async {
    super.onLoad();
    children.register<ShapeHitbox>();
  }

  Vector2 absoluteCenterOfMainHitbox() {
    if (hitboxes.isNotEmpty) {
      return hitboxes.first.absoluteCenter;
    }

    return absoluteCenter;
  }

  Vector2 absoluteBottomOfMainHitbox() {
    if (hitboxes.isNotEmpty) {
      return hitboxes.first.absoluteCenter;
    }

    return absoluteCenter;
  }
}
