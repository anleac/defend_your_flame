import 'package:defend_your_flame/core/flame/components/hud/mixins/has_purchase_status.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_state.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DependencyLine extends PositionComponent with HasWorldReference<MainWorld>, HasPurchaseStatus {
  late final Paint _paint = Paint()
    ..color = Colors.white70
    ..strokeWidth = thickness
    ..style = PaintingStyle.stroke;

  final Purchaseable dependency;
  final double thickness;
  final Vector2 start;
  final Vector2 end;

  DependencyLine({
    required this.start,
    required this.end,
    required this.dependency,
    this.thickness = 7,
  }) {
    initPurchaseState(dependency);
  }

  @override
  void onStateChange(PurchaseState updatedState) {
    _paint.color = purchaseState.opaqueColor;
    super.onStateChange(updatedState);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(start.toOffset(), end.toOffset(), _paint);
  }
}
