import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flame_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';

class ManaProducingFlame extends Purchaseable {
  ManaProducingFlame(AppStrings appStrings)
      : super(
          type: PurchaseableType.manaProducingFlame,
          dependencies: {PurchaseableType.strongFlame},
          conflictingPurchases: {PurchaseableType.totemEnhancingFlame},
          category: PurchaseableCategory.flame,
          name: appStrings.manaProducingFlameName,
          description: AppStringHelper.insertNumbers(appStrings.manaProducingFlameDescription, [
            MiscHelper.doubleDifferenceToPercentage(FlameType.manaProducing.manaOutput, FlameType.strong.manaOutput),
          ]),
          quote: appStrings.manaProducingFlameQuote,
          cost: [220],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.firePit.updateType(FlameType.manaProducing);
    super.purchase(world);
  }
}
