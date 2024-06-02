import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/entities/npcs/alchemist.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class AlchemistPurchase extends Purchaseable {
  AlchemistPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.alchemist,
          category: PurchaseableCategory.npcs,
          name: appStrings.alchemistName,
          description: AppStringHelper.insertNumbers(
              appStrings.alchemistDescription, [Alchemist.goldToGatherEachRound, Alchemist.manaToGatherEachRound]),
          quote: appStrings.alchemistQuote,
          cost: [280],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.purchaseAlchemist();
    super.purchase(world);
  }
}
