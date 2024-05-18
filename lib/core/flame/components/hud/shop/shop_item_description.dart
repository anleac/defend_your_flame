import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop/shop_item_action_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop/shop_item_close_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_cost_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_description_title.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/item_title.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class ShopItemDescription extends PositionComponent
    with HasWorldReference<MainWorld>, HasGameReference<MainGame>, DragCallbacks {
  static const double padding = 20;
  static final Vector2 _itemGap = Vector2(0, 35);
  Purchaseable? _selectedItem;

  late final BorderedBackground _bodyBackground = BorderedBackground(hasFill: true, opacity: 0.25)
    ..position = Vector2.zero()
    ..anchor = Anchor.topLeft
    ..size = size;

  late final ItemTitle _itemTitle = ItemTitle()..position = Vector2(padding, padding);

  late final ItemCostText _costText = ItemCostText()..position = _itemTitle.position + _itemGap;

  late final ItemDescriptionTitle _descriptionLabel = ItemDescriptionTitle()
    ..position = _costText.position + (_itemGap * 1.5)
    ..anchor = Anchor.topLeft;

  late final TextComponent _descriptionText = TextComponent(
    text: '',
    textRenderer: TextManager.basicHudRenderer,
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

  late final ShopItemCloseButton _closeButton = ShopItemCloseButton()
    ..anchor = Anchor.topRight
    ..position = Vector2(size.x - padding, padding);

  PurchaseableType? get selectedItemType => _selectedItem?.type;

  @override
  Future<void> onLoad() async {
    add(_bodyBackground);
    add(_itemTitle);
    add(_costText);
    add(_descriptionLabel);
    add(_descriptionText);
    add(_purchaseCountText);
    add(_quoteText);
    add(_itemActionButton);
    add(_closeButton);
    return super.onLoad();
  }

  void itemSelected(Purchaseable selectedItem) {
    _selectedItem = selectedItem;

    _itemTitle.updateText(_selectedItem?.name ?? '');

    _descriptionText.text = _selectedItem?.description ?? '';
    _quoteText.text = _selectedItem?.quote ?? '';
  }

  @override
  void update(double dt) {
    _updateUx();
    super.update(dt);
  }

  void tryToBuy() {
    if (_purchasePossible && _selectedItem != null) {
      world.shopManager.handlePurchase(_selectedItem!.type);
      _updateUx();
    }
  }

  void _updateUx() {
    _costText.updateText(_selectedItem?.currentCost.toString() ?? '');
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
      _itemActionButton.updateAction(PurchaseState.purchased);
    } else if (_dependenciesMissing) {
      _itemActionButton.updateAction(PurchaseState.missingDependencies);
    } else {
      _itemActionButton.updateAction(_purchasePossible ? PurchaseState.canPurchase : PurchaseState.cantAfford);
    }
  }

  bool get _dependenciesMissing =>
      _selectedItem != null && !world.shopManager.dependenciesPurchased(_selectedItem!.type);

  bool get _purchasePossible =>
      _selectedItem != null &&
      world.playerBase.totalGold >= _selectedItem!.currentCost &&
      !_selectedItem!.purchasedMaxAmount;
}
