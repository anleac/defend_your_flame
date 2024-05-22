import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/shop/defenses/attack_totem_purchase.dart';
import 'package:defend_your_flame/core/flame/shop/npcs/blacksmith_purchase.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/shop/walls/wooden_wall_purchase.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/walls/stone_wall_purchase.dart';
import 'package:flame/components.dart';

class ShopManager extends Component with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final Map<PurchaseableType, Purchaseable> _purchasables = {
    PurchaseableType.woodenWall: WoodenWallPurchase(game.appStrings),
    PurchaseableType.stoneWall: StoneWallPurchase(game.appStrings),
    PurchaseableType.attackTotem: AttackTotemPurchase(game.appStrings),
    PurchaseableType.blacksmith: BlacksmithPurchase(game.appStrings),
  };

  final List<PurchaseableType> _purchaseOrder = [];
  final Set<PurchaseableType> _purchasedMap = {};

  Iterable<Purchaseable> get purchasables => _purchasables.values;
  Set<PurchaseableType> get purchasedMap => _purchasedMap;
  List<PurchaseableType> get purchaseOrder => _purchaseOrder;

  bool isPurchased(PurchaseableType type) => _purchasedMap.contains(type) && _purchasables[type]!.purchasedMaxAmount;
  bool dependenciesPurchased(PurchaseableType type) =>
      _purchasables[type]!.dependencies.isEmpty || _purchasables[type]!.dependencies.every(isPurchased);

  Purchaseable getPurchaseable(PurchaseableType type) => _purchasables[type]!;

  void handlePurchase(PurchaseableType type, {bool restoringSave = false}) {
    var purchase = _purchasables[type]!;
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

    for (var element in _purchasables.values) {
      element.reset();
    }
  }
}
