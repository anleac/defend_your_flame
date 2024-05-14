import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/entities/npcs/blacksmith.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class BlacksmithPurchase extends Purchasable {
  BlacksmithPurchase(AppStrings appStrings)
      : super(
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
