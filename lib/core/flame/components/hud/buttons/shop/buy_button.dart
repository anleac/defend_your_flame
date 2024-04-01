import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:flame/components.dart';

class BuyButton extends DefaultButton with ParentIsA<ShopItemDescription> {
  BuyButton() : super();

  @override
  void onMount() {
    text = game.appStrings.buy;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.tryToBuy();
  }
}
