import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:defend_your_flame/core/flame/shop/walls/wooden_wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';

class StoneWallPurchase extends Purchasable {
  StoneWallPurchase(AppStrings appStrings)
      : super(
          name: appStrings.stoneWallName,
          description: TranslationHelper.insertNumbers(appStrings.stoneWallDescription, [
            WallHelper.totalHealth(WallType.stone) - WallHelper.totalHealth(WallType.wood),
            WallHelper.defenseValue(WallType.stone) - WallHelper.defenseValue(WallType.wood),
          ]),
          cost: 110,
          oneOffPurchase: true,
          dependencies: {WoodenWallPurchase},
        );

  @override
  void purchase(MainWorld world) {
    world.playerManager.playerBase.wall.updateWallType(WallType.stone);
    super.purchase(world);
  }
}
