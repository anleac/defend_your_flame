import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:flame/components.dart';

class ShopItemDescription extends PositionComponent with ParentIsA<MainShopHud> {
  Purchasable? _selectedItem;

  late final BorderedBackground _background = BorderedBackground(hasFill: false)
    ..position = Vector2.zero()
    ..size = size;

  // TODO shift the text to be read from app_strings
  late final TextComponent _text = TextComponent(text: 'Select an item')
    ..anchor = Anchor.center
    ..position = size / 2;

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_text);
    return super.onLoad();
  }

  void itemSelected(Purchasable? selectedItem) {
    _selectedItem = selectedItem;
    _text.text = selectedItem?.description ?? 'Select an item';
  }
}
