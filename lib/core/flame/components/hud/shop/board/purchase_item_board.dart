import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:defend_your_flame/core/flame/components/hud/components/dependency_line.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_item.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_drag.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PurchaseItemBoard extends PositionComponent
    with TapCallbacks, DragCallbacks, HasGameReference<MainGame>, HasWorldReference<MainWorld>, HasMouseDrag {
  static const double padding = 30;
  static const double verticalItemPadding = PurchaseItem.rectangleHeight * 2;
  static const double horizontalItemPadding = PurchaseItem.rectangleWidth * 1.2;

  late final Vector2 _maximumClamp;
  late final Vector2 _minimumClamp;

  final PositionComponent _dragScreen = PositionComponent();

  final Vector2 independentPurchaseGap = Vector2(0, verticalItemPadding);
  final Vector2 dependentPurchaseGap = Vector2(horizontalItemPadding, 0);

  final Iterable<Purchaseable> purchaseables;

  Vector2 _dragOffset = Vector2.zero();

  PurchaseItemBoard(this.purchaseables);

  @override
  FutureOr<void> onLoad() {
    Vector2 currentPosition = Vector2.all(padding);
    Vector2 halfHorizontal = Vector2(PurchaseItem.rectangleWidth / 2, 0);

    // We need to build a dependency graph using topological sort, and then also have some ordering by name
    // such that the topological sort is deterministic.
    // Flashbacks to ACM ICPC days, it's just a bit annoying because the dependencies are nested inside.
    // This is fairly naive, as it builds the "graph" somewhat in real time, the efficiency is somewhat bad, it goes up to O(n^2).
    // We can inefficiently build out a tree, given we know we should only ever have <20 upgrades PER board, at most, if not less.
    // We can revisit if we ever hit perf issues, but I honestly highly doubt it.
    // Don't always need to golden plate =) Remember how bad the Terraria code was and that game was epic (as much as it pains me to say).

    // An adjacency list of dependencies, we can use this to build a tree.
    Map<PurchaseableType, List<PurchaseableType>> purchaseMapTree = {};
    Set<PurchaseableType> nodesWithoutDependencies = {};
    Map<PurchaseableType, Purchaseable> purchaseMap = {};

    // Prepopulate the data
    for (Purchaseable purchaseable in purchaseables) {
      purchaseMap[purchaseable.type] = purchaseable;
      if (purchaseable.dependencies.isEmpty) {
        nodesWithoutDependencies.add(purchaseable.type);
      }

      purchaseMapTree[purchaseable.type] = [];
    }

    for (var purchaseable in purchaseables) {
      // Generate the connection tree
      for (var dependency in purchaseable.dependencies) {
        purchaseMapTree[dependency]!.add(purchaseable.type);
      }
    }

    var lineOffset = Vector2(PurchaseItem.rectangleWidth, PurchaseItem.rectangleHeight) / 2;

    double lowestY = double.infinity;
    double highestY = double.negativeInfinity;
    double lowestX = double.infinity;
    double highestX = double.negativeInfinity;

    // Now do a BFS based on the nodes without dependencies, since it's a tree, we shouldn't in theory need to keep
    // a visited tracker because we can't have cycles.
    for (var purchaseableType in nodesWithoutDependencies) {
      Queue<(PurchaseableType type, Vector2 position)> queue = Queue();
      queue.add((purchaseableType, currentPosition));

      while (queue.isNotEmpty) {
        var (currentType, internalPosition) = queue.removeFirst();

        var chains = purchaseMapTree[currentType]!;
        final minYOffset = -(chains.length - 1) * independentPurchaseGap.y / 2;
        final yOffsetPerChain = independentPurchaseGap.y;

        for (int i = 0; i < chains.length; i++) {
          var chainedPosition = internalPosition + Vector2(dependentPurchaseGap.x, minYOffset + i * yOffsetPerChain);
          _dragScreen.add(DependencyLine(
              start: internalPosition + halfHorizontal + lineOffset,
              end: chainedPosition - halfHorizontal + lineOffset,
              dependency: purchaseMap[chains[i]]!));

          queue.add((chains[i], chainedPosition));
        }

        _dragScreen.add(PurchaseItem(purchaseMap[currentType]!)..position = internalPosition);
        lowestY = min(lowestY, internalPosition.y);
        highestY = max(highestY, internalPosition.y);
        lowestX = min(lowestX, internalPosition.x);
        highestX = max(highestX, internalPosition.x);
      }

      currentPosition += independentPurchaseGap;
    }

    double initialY = size.y / 2;
    double yRange = highestY - lowestY;
    if (yRange > size.y - 2 * padding) {
      // If the range is larger than the screen, simply put the initial position with the first element at the top
      initialY = lowestY + (padding / 2);
    }

    _dragOffset = Vector2(0, initialY) - Vector2(0, PurchaseItem.rectangleHeight);
    _dragScreen.position = _dragOffset;

    // TODO these clamps still need to be fixed
    _minimumClamp = Vector2(-highestX + padding, -highestY + padding);
    _maximumClamp = Vector2(size.x - lowestX - padding, size.y - lowestY - padding);

    add(_dragScreen);

    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // TODO make sure this window scale is correct
    _dragOffset += (event.canvasDelta / game.windowScale);
    _dragOffset.clamp(_minimumClamp, _maximumClamp);

    _dragScreen.position = _dragOffset;

    super.onDragUpdate(event);
  }
}
