import 'dart:async';
import 'dart:math';

import 'package:defend_your_flame/core/flame/components/hud/components/line_between.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_item.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_drag.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PurchaseItemBoard extends PositionComponent
    with TapCallbacks, DragCallbacks, HasGameReference<MainGame>, HasMouseDrag {
  static const double padding = 30;
  static const double verticalItemPadding = PurchaseItem.rectangleWidthAndHeight * 1.5;
  static const double horizontalItemPadding = verticalItemPadding * 1.2;

  late final Vector2 _maximumClamp;
  late final Vector2 _minimumClamp;

  final Vector2 independentPurchaseGap = Vector2(0, verticalItemPadding);
  final Vector2 dependentPurchaseGap = Vector2(horizontalItemPadding, 0);

  final Iterable<Purchaseable> purchaseables;

  PurchaseItemBoard(this.purchaseables);

  @override
  FutureOr<void> onLoad() {
    Vector2 currentPosition = Vector2.all(padding);
    Vector2 halfHorizontal = Vector2(PurchaseItem.rectangleWidthAndHeight / 2, 0);

    // We need to build a dependency graph using topological sort, and then also have some ordering by name
    // such that the topological sort is deterministic.
    // Flashbacks to ACM ICPC days, it's just a bit annoying because the dependencies are nested inside.
    // This is fairly naive, as it builds the "graph" somewhat in real time, the efficiency is somewhat bad, it goes up to O(n^2).
    // Let's revisit, but honestly, we will probably only ever have < 20 upgrades at most.
    Map<PurchaseableType, Vector2> purchasePositions = {};

    while (purchasePositions.length < purchaseables.length) {
      for (Purchaseable purchaseable in purchaseables) {
        if (purchasePositions.containsKey(purchaseable.type)) {
          continue;
        }

        if (purchaseable.dependencies.any((d) => !purchasePositions.containsKey(d))) {
          continue;
        }

        // We have two choices, we are either an isolated node, or we are a dependent node and have to chain to the right
        var item = PurchaseItem(purchaseable);
        if (purchaseable.dependencies.isEmpty) {
          item.position = currentPosition;
          currentPosition += independentPurchaseGap;
        } else {
          // This naively (for now) assumes only one dependecy, we can revisit.
          var previousPosition = purchasePositions[purchaseable.dependencies.first]!;
          item.position = previousPosition + dependentPurchaseGap;
          var lineOffset = Vector2.all(PurchaseItem.rectangleWidthAndHeight) / 2;
          add(LineBetween(
              start: previousPosition + halfHorizontal + lineOffset, end: item.position - halfHorizontal + lineOffset));
        }

        purchasePositions[purchaseable.type] = item.position;
        add(item);
      }
    }

    var dragXOffScreen = max(currentPosition.x - size.x, 0).toDouble();
    var dragYOffScreen = max(currentPosition.y - size.y, 0).toDouble();

    var dragBuffer = (independentPurchaseGap + dependentPurchaseGap - Vector2.all(padding)) / 2;

    _maximumClamp = Vector2(dragXOffScreen, dragYOffScreen) + dragBuffer;
    _minimumClamp = -dragBuffer;

    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // TODO make sure this window scale is correct
    position += (event.canvasDelta / game.windowScale);
    position.clamp(_minimumClamp, _maximumClamp);

    super.onDragUpdate(event);
  }
}
