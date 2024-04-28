import 'package:defend_your_flame/core/shop/purchasable.dart';

class StoneWallPurchase extends Purchasable {
  StoneWallPurchase()
      : super(
          name: 'Stone Wall',
          description:
              '- +40 max health\n\n- +1 defence\n\n\n\n"I found a wall of wood, and left it a wall\nof stone."',
          cost: 110,
          oneOffPurchase: true,
        );
}
