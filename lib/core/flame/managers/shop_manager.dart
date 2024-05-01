import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/shop/walls/wooden_wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/shop/walls/stone_wall.dart';
import 'package:flame/components.dart';

class ShopManager extends Component with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  late final List<Purchasable> _purchasables = [
    WoodenWallPurchase(game.appStrings),
    StoneWallPurchase(game.appStrings),
  ];

  List<Purchasable> get purchasables => _purchasables;

  void handlePurchase(Purchasable purchasable) {
    var purchaseIndex = _purchasables.indexWhere((element) => element == purchasable);
    if (_purchasables[purchaseIndex].purchased || world.playerManager.totalGold < purchasable.cost) {
      return;
    }

    _purchasables[purchaseIndex].purchase(world);
    world.playerManager.mutateGold(-purchasable.cost);
  }
}
