import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:defend_your_flame/core/shop/walls/stone_wall.dart';

class ShopManager {
  final List<Purchasable> _purchasables = [
    StoneWallPurchase(),
  ];

  List<Purchasable> get purchasables => _purchasables;
}
