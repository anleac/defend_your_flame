import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:flame/components.dart';

class ShopItemCloseButton extends DefaultButton with ParentIsA<ShopItemDescription> {
  ShopItemCloseButton() : super(underlined: false);

  @override
  FutureOr<void> onLoad() {
    text = game.appStrings.close;
    return super.onLoad();
  }

  @override
  void onPressed() {
    parent.removeFromParent();
    super.onPressed();
  }
}
