import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_state.dart';
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
  void update(double dt) {
    super.update(dt);

    var isPurchased = world.shopManager.isPurchased(_purchaseable.type);
    if (isPurchased) {
      _purchaseState = PurchaseState.purchased;
      return;
    }

    if (!world.shopManager.dependenciesPurchased(_purchaseable.type)) {
      _purchaseState = PurchaseState.missingDependencies;
      return;
    }

    if (world.playerBase.totalGold >= _purchaseable.currentCost) {
      _purchaseState = PurchaseState.canPurchase;
    } else {
      _purchaseState = PurchaseState.cantAfford;
    }
  }
}
