import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/shop/defenses/attack_totem_purchase.dart';
import 'package:defend_your_flame/core/flame/shop/walls/wooden_wall_purchase.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/shop/walls/stone_wall_purchase.dart';
import 'package:flame/components.dart';

class ShopManager extends Component with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final List<Purchasable> _purchasables = [
    WoodenWallPurchase(game.appStrings),
    StoneWallPurchase(game.appStrings),
    AttackTotemPurchase(game.appStrings),
  ];

  List<Purchasable> get purchasables => _purchasables;

  void handlePurchase(Purchasable purchasable) {
    var purchaseIndex = _purchasables.indexWhere((element) => element == purchasable);
    if (_purchasables[purchaseIndex].purchasedMaxAmount || world.playerBase.totalGold < purchasable.currentCost) {
      return;
    }

    world.playerBase.mutateGold(-purchasable.currentCost);
    _purchasables[purchaseIndex].purchase(world);
  }

  void resetPurchases() {
    for (var element in _purchasables) {
      element.reset();
    }
  }
}
