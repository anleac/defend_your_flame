import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class WoodenWallPurchase extends Purchasable {
  WoodenWallPurchase(AppStrings appStrings)
      : super(
          name: appStrings.woodenWallName,
          description: AppStringHelper.insertNumbers(appStrings.woodenWallDescription, [
            WallHelper.totalHealth(WallType.wood) - WallHelper.totalHealth(WallType.barricade),
            WallHelper.defenseValue(WallType.wood) - WallHelper.defenseValue(WallType.barricade),
          ]),
          quote: appStrings.woodenWallQuote,
          cost: [170],
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.wall.updateWallType(WallType.wood);
    super.purchase(world);
  }
}
