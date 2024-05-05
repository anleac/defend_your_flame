import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop/shop_item_action_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_cost_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_description_title.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_title.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';
import 'package:flame/components.dart';

class ShopItemDescription extends PositionComponent
    with ParentIsA<MainShopHud>, HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  static const double padding = 20;
  static final Vector2 _itemGap = Vector2(0, 35);
  Purchasable? _selectedItem;

  late final ItemTitle _itemTitle = ItemTitle()..position = Vector2(padding, padding);

  late final ItemCostText _costText = ItemCostText()..position = _itemTitle.position + _itemGap;

  late final ItemDescriptionTitle _descriptionLabel = ItemDescriptionTitle()
    ..position = _costText.position + (_itemGap * 1.5)
    ..anchor = Anchor.topLeft;

  late final TextComponent _descriptionText = TextComponent(
    text: '',
    textRenderer: TextManager.smallSubHeaderBoldRenderer,
  )..position = _descriptionLabel.position + _itemGap;

  late final TextComponent _purchaseCountText = TextComponent(
    text: '',
    textRenderer: TextManager.smallSubHeaderBoldRenderer,
  )
    ..position = Vector2(_itemTitle.x, size.y) - Vector2(0, padding)
    ..anchor = Anchor.bottomLeft;

  late final TextComponent _quoteText = TextComponent(
    text: '',
    textRenderer: TextManager.basicHudItalicRenderer,
  )..position = _purchaseCountText.position - (_itemGap * 2);

  late final ShopItemActionButton _itemActionButton = ShopItemActionButton()
    ..anchor = Anchor.bottomRight
    ..position = size - Vector2(padding, padding);

  @override
  Future<void> onLoad() async {
    add(_itemTitle);
    add(_costText);
    add(_descriptionLabel);
    add(_descriptionText);
    add(_purchaseCountText);
    add(_quoteText);
    add(_itemActionButton);
    return super.onLoad();
  }

  void itemSelected(Purchasable? selectedItem) {
    _selectedItem = selectedItem;

    _itemTitle.updateText(_selectedItem?.name ?? '');
    _costText.updateText(_selectedItem?.cost.toString() ?? '');

    _descriptionText.text = _selectedItem?.description ?? '';
    _quoteText.text = _selectedItem?.quote ?? '';

    _updateUx();
  }

  void tryToBuy() {
    if (_purchasePossible) {
      world.shopManager.handlePurchase(_selectedItem!);
      _updateUx();
      parent.refreshShopList();
    }
  }

  void _updateUx() {
    _updatePurchaseCountText();
    _updateActionButton();
  }

  void _updatePurchaseCountText() {
    if (_selectedItem == null) {
      return;
    }

    _purchaseCountText.text = (_selectedItem!.maxPurchaseCount) > 1
        ? AppStringHelper.insertNumbers(
            game.appStrings.potentialPurchaseCount, [_selectedItem!.purchaseCount, _selectedItem!.maxPurchaseCount])
        : '';
  }

  void _updateActionButton() {
    if (_selectedItem == null) {
      return;
    }

    if (_selectedItem!.purchasedMaxAmount) {
      _itemActionButton.updateAction(ShopItemActionButtonState.alreadyPurchased);
    } else {
      _itemActionButton.updateAction(
          _purchasePossible ? ShopItemActionButtonState.canPurchase : ShopItemActionButtonState.cantAfford);
    }
  }

  bool get _purchasePossible =>
      _selectedItem != null && world.playerBase.totalGold >= _selectedItem!.cost && !_selectedItem!.purchasedMaxAmount;
}
