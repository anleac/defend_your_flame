import 'dart:math';

import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class AttackTotemPurchase extends Purchaseable {
  static const int maxTotems = 6;
  static const double totemCostProgression = 1.25;
  static const int initialCost = 120;

  static final List<int> costs =
      List<int>.generate(maxTotems, (i) => (10 * ((initialCost * pow(totemCostProgression, i)) / 10).ceil()));

  AttackTotemPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.attackTotem,
          category: PurchaseableCategory.defenses,
          name: appStrings.attackTotemName,
          description: appStrings.attackTotemDescription,
          quote: appStrings.attackTotemQuote,
          cost: costs,
          maxPurchaseCount: maxTotems,
        );

  @override
  void purchase(MainWorld world) {
    // This hasn't been incremented yet, so we need to add the purchase count.
    world.playerBase.addAttackTotem(purchaseCount);
    super.purchase(world);
  }
}
