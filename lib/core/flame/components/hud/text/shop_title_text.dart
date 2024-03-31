import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_text.dart';

class ShopTitleText extends DefaultText {
  @override
  void onMount() {
    text = game.appStrings.shop;
    super.onMount();
  }
}
