import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

enum ShopItemActionButtonState { canPurchase, cantAfford, alreadyPurchased }

class ShopItemActionButton extends DefaultButton with ParentIsA<ShopItemDescription> {
  static final TextPaint _canPurchaseRenderer = TextManager.smallHeaderRenderer;
  static final TextPaint _cantAffordRenderer =
      TextManager.copyWith(_canPurchaseRenderer, color: ThemingConstants.cantAffordColour);

  static final TextPaint _alreadyPurchasedRenderer =
      TextManager.copyWith(_canPurchaseRenderer, color: ThemingConstants.purchasedItemColour);

  ShopItemActionButtonState _actionState = ShopItemActionButtonState.canPurchase;

  ShopItemActionButton() : super();

  @override
  void onMount() {
    text = game.appStrings.buy;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.tryToBuy();
  }

  void updateAction(ShopItemActionButtonState actionState) {
    _actionState = actionState;
    switch (_actionState) {
      case ShopItemActionButtonState.canPurchase:
        text = game.appStrings.buy;
        textRenderer = _canPurchaseRenderer;
        break;
      case ShopItemActionButtonState.cantAfford:
        text = game.appStrings.cantAfford;
        textRenderer = _cantAffordRenderer;
        break;
      case ShopItemActionButtonState.alreadyPurchased:
        text = game.appStrings.alreadyPurchased;
        textRenderer = _alreadyPurchasedRenderer;
        break;
    }

    super.toggleClickable(_actionState == ShopItemActionButtonState.canPurchase);
  }
}
