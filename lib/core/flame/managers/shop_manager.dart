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

  Set<PurchaseableType> _purchased = {};

  Iterable<Purchaseable> get purchasables => _purchasables.values;
  Set<PurchaseableType> get purchased => _purchased;

  bool get blacksmithPurchased => _purchasables[PurchaseableType.blacksmith]!.purchasedMaxAmount;

  void handlePurchase(PurchaseableType type) {
    var purchase = _purchasables[type]!;
    if (purchase.purchasedMaxAmount || world.playerBase.totalGold < purchase.currentCost) {
      return;
    }

    world.playerBase.mutateGold(-purchase.currentCost);
    purchase.purchase(world);
    _purchased.add(type);
  }

  void resetPurchases() {
    _purchased.clear();

    for (var element in _purchasables.values) {
      element.reset();
    }
  }
}
