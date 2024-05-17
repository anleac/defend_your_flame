import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/managers/text/shop_text_manager.dart';
import 'package:flame/components.dart';

enum ShopItemActionButtonState { canPurchase, cantAfford, alreadyPurchased }

class ShopItemActionButton extends DefaultButton with ParentIsA<ShopItemDescription> {
  ShopItemActionButtonState _actionState = ShopItemActionButtonState.canPurchase;

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

  void updateAction(ShopItemActionButtonState actionState) {
    _actionState = actionState;
    switch (_actionState) {
      case ShopItemActionButtonState.canPurchase:
        text = game.appStrings.buy;
        textRenderer = ShopTextManager.canPurchaseRenderer;
        break;
      case ShopItemActionButtonState.cantAfford:
        text = game.appStrings.cantAfford;
        textRenderer = ShopTextManager.cantAffordRenderer;
        break;
      case ShopItemActionButtonState.alreadyPurchased:
        text = game.appStrings.alreadyPurchased;
        textRenderer = ShopTextManager.alreadyPurchasedRenderer;
        break;
    }

    super.toggleClickable(_actionState == ShopItemActionButtonState.canPurchase);
  }
}
