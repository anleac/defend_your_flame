import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_helper.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall_type.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

class StoneWallPurchase extends Purchaseable {
  StoneWallPurchase(AppStrings appStrings)
      : super(
          type: PurchaseableType.stoneWall,
          name: appStrings.stoneWallName,
          description: AppStringHelper.insertNumbers(appStrings.stoneWallDescription, [
            WallHelper.totalHealth(WallType.stone) - WallHelper.totalHealth(WallType.wood),
            WallHelper.defenseValue(WallType.stone) - WallHelper.defenseValue(WallType.wood),
          ]),
          quote: appStrings.stoneWallQuote,
          cost: [320],
          dependencies: {PurchaseableType.woodenWall},
        );

  @override
  void purchase(MainWorld world) {
    world.playerBase.wall.updateWallType(WallType.stone);
    super.purchase(world);
  }
}
