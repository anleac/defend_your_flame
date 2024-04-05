import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop/buy_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_cost_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_description_title.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_title.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:flame/components.dart';

class ShopItemDescription extends PositionComponent with ParentIsA<MainShopHud>, HasWorldReference<MainWorld> {
  static const double padding = 20;
  static final Vector2 _itemGap = Vector2(0, 35);
  Purchasable? _selectedItem;

  late final BorderedBackground _background = BorderedBackground(hasFill: false)
    ..position = Vector2.zero()
    ..size = size;

  late final ItemTitle _itemTitle = ItemTitle()..position = Vector2(padding, padding);

  late final ItemCostText _costText = ItemCostText()..position = _itemTitle.position + _itemGap;

  late final ItemDescriptionTitle _descriptionLabel = ItemDescriptionTitle()
    ..position = _costText.position + (_itemGap * 2)
    ..anchor = Anchor.topLeft;

  late final TextComponent _descriptionText = TextComponent(
    text: '',
    textRenderer: TextManager.basicHudRenderer,
  )..position = _descriptionLabel.position + _itemGap;

  late final BuyButton _buyButton = BuyButton()
    ..isVisible = false
    ..anchor = Anchor.bottomRight
    ..position = size - Vector2(padding, padding);

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_itemTitle);
    add(_costText);
    add(_descriptionLabel);
    add(_descriptionText);
    add(_buyButton);
    return super.onLoad();
  }

  void itemSelected(Purchasable? selectedItem) {
    _selectedItem = selectedItem;

    _itemTitle.updateText(_selectedItem?.name ?? '');
    _costText.updateText(_selectedItem?.cost.toString() ?? '');

    _descriptionText.text = _selectedItem?.description ?? '';

    _buyButton.isVisible = _purchasePossible;
  }

  void tryToBuy() {
    if (_purchasePossible) {
      world.shopManager.handlePurchase(_selectedItem!);
      _buyButton.isVisible = false;
    }
  }

  bool get _purchasePossible =>
      _selectedItem != null && world.playerManager.totalGold >= _selectedItem!.cost && !_selectedItem!.purchased;
}