import 'package:defend_your_flame/core/flame/components/hud/base_components/text_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_list.dart';
import 'package:defend_your_flame/core/flame/managers/text/shop_text_manager.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:flame/components.dart';

class ShopItemButton extends TextButton with ParentIsA<ShopItemList>, HasAncestor<MainShopHud> {
  final Purchaseable purchasable;

  ShopItemButton(this.purchasable)
      : super(
          text: purchasable.name,
          underlined: false,
          comingSoon: purchasable.comingSoon,
          defaultTextRenderer: purchasable.purchasedMaxAmount
              ? ShopTextManager.alreadyPurchasedRenderer
              : ShopTextManager.canPurchaseRenderer,
          hoveredTextRenderer: purchasable.purchasedMaxAmount
              ? ShopTextManager.alreadyPurchasedRendererHovered
              : ShopTextManager.canPurchaseRendererHovered,
          disabledRenderer: purchasable.purchasedMaxAmount
              ? ShopTextManager.alreadyPurchasedRendererDisabled
              : ShopTextManager.canPurchaseRendererDisabled,
        );

  @override
  void onPressed() {
    ancestor.showItemDescription(purchasable);
    super.onPressed();
  }
}
