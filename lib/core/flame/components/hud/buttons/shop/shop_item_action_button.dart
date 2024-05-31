import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';

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
        break;
      case PurchaseState.cantAfford:
        text = game.appStrings.cantAfford;
        break;
      case PurchaseState.purchased:
        text = game.appStrings.alreadyPurchased;
        break;
      case PurchaseState.missingDependencies:
        text = game.appStrings.missingDependencies;
        break;
      case PurchaseState.conflictingPurchase:
        text = game.appStrings.conflictingPurchase;
        break;
    }

    decorator.removeLast();
    decorator.addLast(PaintDecorator.tint(actionState.lightenedColor));

    super.toggleClickable(_actionState == PurchaseState.canPurchase);
  }
}
