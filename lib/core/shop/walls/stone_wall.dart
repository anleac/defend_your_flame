import 'package:defend_your_flame/core/shop/purchasable.dart';

class StoneWallPurchase extends Purchasable {
  StoneWallPurchase()
      : super(
          name: 'Stone Wall',
          description: '"I found a wall of wood, and left it a wall\nof stone."',
          cost: 110,
          oneOffPurchase: true,
        );
}
