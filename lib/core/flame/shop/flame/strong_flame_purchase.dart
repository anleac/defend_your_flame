import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flame_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';

class StrongFlamePurchase extends Purchaseable {
  StrongFlamePurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.strongFlame,
          category: PurchaseableCategory.flame,
          name: appStrings.strongFlameName,
          description: AppStringHelper.insertNumbers(appStrings.strongFlameDescription, [
            MiscHelper.doubleDifferenceToPercentage(FlameType.strong.manaOutput, FlameType.basic.manaOutput),
            MiscHelper.doubleDifferenceToPercentage(FlameType.strong.totemIncrease, FlameType.basic.totemIncrease),
          ]),
          quote: appStrings.strongFlameQuote,
          cost: [150],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.firePit.updateType(FlameType.strong);
    super.purchase(world);
  }
}
