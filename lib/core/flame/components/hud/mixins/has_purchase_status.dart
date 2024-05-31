import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_state.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

mixin HasPurchaseStatus on Component, HasWorldReference<MainWorld> {
  late Purchaseable _purchaseable;

  PurchaseState _purchaseState = PurchaseState.canPurchase;

  PurchaseState get purchaseState => _purchaseState;

  void initPurchaseState(Purchaseable purchaseable) {
    _purchaseable = purchaseable;
  }

  bool get isPurchased => _purchaseState == PurchaseState.purchased;
  bool get missingDependencies => _purchaseState == PurchaseState.missingDependencies;
  bool get cantAfford => _purchaseState == PurchaseState.cantAfford;
  bool get canPurchase => _purchaseState == PurchaseState.canPurchase;

  @override
  FutureOr<void> onLoad() {
    onStateChange(_purchaseState);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    var isPurchased = world.shopManager.isPurchased(_purchaseable.type);
    if (isPurchased) {
      _updateState(PurchaseState.purchased);
      return;
    }

    if (_purchaseable.conflictingPurchases.isNotEmpty &&
        _purchaseable.conflictingPurchases.any(world.shopManager.isPurchased)) {
      _updateState(PurchaseState.conflictingPurchase);
      return;
    }

    if (!world.shopManager.dependenciesPurchased(_purchaseable.type)) {
      _updateState(PurchaseState.missingDependencies);
      return;
    }

    if (world.playerBase.totalGold >= _purchaseable.currentCost) {
      _updateState(PurchaseState.canPurchase);
    } else {
      _updateState(PurchaseState.cantAfford);
    }
  }

  // Intended to be overriden
  void onStateChange(PurchaseState updatedState) {}

  void _updateState(PurchaseState state) {
    if (_purchaseState != state) {
      _purchaseState = state;
      onStateChange(state);
    }
  }
}
