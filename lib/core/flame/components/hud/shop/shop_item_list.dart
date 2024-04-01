import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop_item_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class ShopItemList extends PositionComponent with ParentIsA<MainShopHud>, HasWorldReference<MainWorld> {
  static const double shopItemHeight = 50;
  static const double padding = 10;

  late final BorderedBackground _background = BorderedBackground(hasFill: false)
    ..position = Vector2.zero()
    ..size = size;

  late final List<ShopItemButton> _buttons;

  @override
  Future<void> onLoad() async {
    add(_background);

    var rollingButtonPosition = Vector2(size.x / 2, shopItemHeight / 2 + padding);
    _buttons = world.shopManager.purchasables.map((item) {
      final button = ShopItemButton(item)
        ..position = rollingButtonPosition
        ..size = Vector2(size.x, shopItemHeight)
        ..anchor = Anchor.center;

      rollingButtonPosition += Vector2(0, shopItemHeight + padding);
      return button;
    }).toList();

    addAll(_buttons);

    return super.onLoad();
  }
}
