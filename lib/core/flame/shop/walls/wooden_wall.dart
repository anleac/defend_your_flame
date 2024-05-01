import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';

class WoodenWallPurchase extends Purchasable {
  WoodenWallPurchase(AppStrings appStrings)
      : super(
          name: appStrings.stoneWallName,
          description: TranslationHelper.insertNumbers(appStrings.stoneWallDescription, [
            WallHelper.totalHealth(WallType.wood) - WallHelper.totalHealth(WallType.barricade),
            WallHelper.defenseValue(WallType.wood) - WallHelper.defenseValue(WallType.barricade),
          ]),
          cost: 65,
          oneOffPurchase: true,
        );

  @override
  void purchase(MainWorld world) {
    world.playerManager.playerBase.wall.updateWallType(WallType.wood);
    super.purchase(world);
  }
}
