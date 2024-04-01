import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_list.dart';
import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:flame/components.dart';

class ShopItemButton extends DefaultButton with ParentIsA<ShopItemList>, HasAncestor<MainShopHud> {
  final Purchasable purchasable;

  ShopItemButton(this.purchasable)
      : super(
          text: purchasable.name,
          underlined: false,
          comingSoon: false,
        );

  @override
  void onPressed() {
    ancestor.showItemDescription(purchasable);
    super.onPressed();
  }
}
