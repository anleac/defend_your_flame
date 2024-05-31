import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/entities/npcs/blacksmith.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class BlacksmithPurchase extends Purchaseable {
  BlacksmithPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.blacksmith,
          category: PurchaseableCategory.npcs,
          name: appStrings.blacksmithName,
          description:
              AppStringHelper.insertNumber(appStrings.blacksmithDescription, Blacksmith.percentageOfWallHealthToRepair),
          quote: appStrings.blacksmithQuote,
          cost: [250],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.purchaseBlacksmith();
    super.purchase(world);
  }
}
