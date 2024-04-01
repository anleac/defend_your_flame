import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:defend_your_flame/core/shop/walls/stone_wall.dart';
import 'package:flame/components.dart';

class ShopManager extends Component with HasWorldReference<MainWorld> {
  final List<Purchasable> _purchasables = [
    StoneWallPurchase(),
  ];

  List<Purchasable> get purchasables => _purchasables;

  void handlePurchase(Purchasable purchasable) {
    var purchaseIndex = _purchasables.indexWhere((element) => element == purchasable);
    if (_purchasables[purchaseIndex].purchased || world.playerManager.totalGold < purchasable.cost) {
      return;
    }

    _purchasables[purchaseIndex].setPurchased();
    world.playerManager.mutateGold(-purchasable.cost);

    if (purchasable is StoneWallPurchase) {
      world.playerManager.playerBase.wall.updateWallType(WallType.stone);
    }
  }
}
