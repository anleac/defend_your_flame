import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class AttackTotemPurchase extends Purchasable {
  static const int maxTotems = 2;

  AttackTotemPurchase(AppStrings appStrings)
      : super(
          name: appStrings.attackTotemName,
          description: appStrings.attackTotemDescription,
          quote: appStrings.attackTotemQuote,
          cost: 120,
          maxPurchaseCount: maxTotems,
        );

  @override
  void purchase(MainWorld world) {
    // This hasn't been incremented yet, so we need to add the purchase count.
    world.playerBase.addAttackTotem(purchaseCount);
    super.purchase(world);
  }
}
