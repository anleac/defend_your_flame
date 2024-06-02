import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class AlchemistPurchase extends Purchaseable {
  static const int goldToGatherEachRound = 30;
  static const int manaToGatherEachRound = 10;

  AlchemistPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.alchemist,
          category: PurchaseableCategory.npcs,
          name: appStrings.alchemistName,
          description: AppStringHelper.insertNumbers(
              appStrings.alchemistDescription, [goldToGatherEachRound, manaToGatherEachRound]),
          quote: appStrings.alchemistQuote,
          cost: [280],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.purchaseAlchemist();
    super.purchase(world);
  }
}
