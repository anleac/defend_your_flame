import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class WoodenWallPurchase extends Purchaseable {
  WoodenWallPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.woodenWall,
          category: PurchaseableCategory.walls,
          name: appStrings.woodenWallName,
          description: AppStringHelper.insertNumbers(appStrings.woodenWallDescription, [
            WallType.wood.totalHealth - WallType.barricade.totalHealth,
            WallType.wood.defenseValue - WallType.barricade.defenseValue,
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
