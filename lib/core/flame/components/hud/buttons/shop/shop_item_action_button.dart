import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/managers/text/shop_text_manager.dart';
import 'package:flame/components.dart';

class ShopItemActionButton extends DefaultButton with ParentIsA<ShopItemDescription> {
  PurchaseState _actionState = PurchaseState.canPurchase;

  ShopItemActionButton() : super();

  @override
  FutureOr<void> onLoad() {
    text = game.appStrings.buy;
    return super.onLoad();
  }

  @override
  void onPressed() {
    parent.tryToBuy();
    super.onPressed();
  }

  void updateAction(PurchaseState actionState) {
    _actionState = actionState;
    switch (_actionState) {
      case PurchaseState.canPurchase:
        text = game.appStrings.buy;
        textRenderer = ShopTextManager.canPurchaseRenderer;
        break;
      case PurchaseState.cantAfford:
        text = game.appStrings.cantAfford;
        textRenderer = ShopTextManager.cantAffordRenderer;
        break;
      case PurchaseState.purchased:
        text = game.appStrings.alreadyPurchased;
        textRenderer = ShopTextManager.alreadyPurchasedRenderer;
        break;
      case PurchaseState.missingDependencies:
        text = game.appStrings.cantAfford; // TODO update this
        textRenderer = ShopTextManager.cantAffordRenderer;
        break;
    }

    super.toggleClickable(_actionState == PurchaseState.canPurchase);
  }
}
