import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/shop/defenses/attack_totem_purchase.dart';
import 'package:defend_your_flame/core/flame/shop/npcs/blacksmith_purchase.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/shop/walls/wooden_wall_purchase.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/walls/stone_wall_purchase.dart';
import 'package:flame/components.dart';

class ShopManager extends Component with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final List<Purchaseable> _allPurchaseables = [
    WoodenWallPurchase(game.appStrings),
    StoneWallPurchase(game.appStrings),
    AttackTotemPurchase(game.appStrings),
    BlacksmithPurchase(game.appStrings),
  ];

  late final Map<PurchaseableType, Purchaseable> _purchasablesByType =
      Map.fromEntries(_allPurchaseables.map((purchaseable) => MapEntry(purchaseable.type, purchaseable)));

  late final Map<PurchaseableCategory, Iterable<PurchaseableType>> _purchaseablesByCategory = Map.fromEntries(
    PurchaseableCategory.values.map((category) => MapEntry(
          category,
          _allPurchaseables
              .where((purchaseable) => purchaseable.category == category)
              .map((purchaseable) => purchaseable.type),
        )),
  );

  final List<PurchaseableType> _purchaseOrder = [];
  final Set<PurchaseableType> _purchasedMap = {};

  Iterable<Purchaseable> get purchasables => _allPurchaseables;
  Set<PurchaseableType> get purchasedMap => _purchasedMap;
  List<PurchaseableType> get purchaseOrder => _purchaseOrder;

  bool isPurchased(PurchaseableType type) =>
      _purchasedMap.contains(type) && _purchasablesByType[type]!.purchasedMaxAmount;
  bool dependenciesPurchased(PurchaseableType type) =>
      _purchasablesByType[type]!.dependencies.isEmpty || _purchasablesByType[type]!.dependencies.every(isPurchased);

  Iterable<Purchaseable> getPurchaseablesByCategory(PurchaseableCategory category) =>
      _purchaseablesByCategory[category]!.map((type) => _purchasablesByType[type]!);

  Purchaseable getPurchaseable(PurchaseableType type) => _purchasablesByType[type]!;

  void handlePurchase(PurchaseableType type, {bool restoringSave = false}) {
    var purchase = _purchasablesByType[type]!;
    if (!restoringSave && (purchase.purchasedMaxAmount || world.playerBase.totalGold < purchase.currentCost)) {
      return;
    }

    if (!restoringSave) {
      world.playerBase.mutateGold(-purchase.currentCost);
    }

    purchase.purchase(world);
    _purchasedMap.add(type);
    _purchaseOrder.add(type);
  }

  void resetPurchases() {
    _purchasedMap.clear();
    _purchaseOrder.clear();

    for (var element in _purchasablesByType.values) {
      element.reset();
    }
  }
}
