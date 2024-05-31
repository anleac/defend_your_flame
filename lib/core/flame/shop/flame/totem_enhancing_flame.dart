import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flame_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';

class TotemEnhancingFlame extends Purchaseable {
  TotemEnhancingFlame(AppStrings appStrings)
      : super(
          type: PurchaseableType.totemEnhancingFlame,
          dependencies: {PurchaseableType.strongFlame},
          conflictingPurchases: {PurchaseableType.manaProducingFlame},
          category: PurchaseableCategory.flame,
          name: appStrings.totemEnhancingFlameName,
          description: AppStringHelper.insertNumbers(appStrings.totemEnhancingFlameDescription, [
            MiscHelper.doubleDifferenceToPercentage(
                FlameType.totemEnhancing.totemIncrease, FlameType.strong.totemIncrease),
          ]),
          quote: appStrings.totemEnhancingFlameQuote,
          cost: [250],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.firePit.updateType(FlameType.totemEnhancing);
    super.purchase(world);
  }
}
