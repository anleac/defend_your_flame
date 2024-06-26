import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/default_hud_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_item_board_selector.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/gold_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/shop_title_text.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class MainShopHud extends BasicHud with ParentIsA<NextRoundHud> {
  static const double padding = 30;

  late final DefaultHudBackground _background = DefaultHudBackground(world: world);

  late final ShopTitleText _shopTitleText = ShopTitleText()
    ..position = _background.headerRect.center.toVector2()
    ..anchor = Anchor.center;

  late final GoldIndicator _goldIndicator = GoldIndicator()
    ..position = _background.headerRect.centerRight.toVector2() - Vector2(padding, 0)
    ..anchor = Anchor.centerRight
    ..scale = Vector2.all(1.5);

  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = _background.headerRect.centerLeft.toVector2() + Vector2(padding, 0)
    ..anchor = Anchor.centerLeft
    ..scale = _goldIndicator.scale;

  late final PurchaseItemBoardSelector _purchaseTabs = PurchaseItemBoardSelector()
    ..size = _background.bodyRect.size.toVector2()
    ..position = _background.bodyRect.topLeft.toVector2()
    ..anchor = Anchor.topLeft;

  late final ShopItemDescription _shopItemDescription = ShopItemDescription()
    ..position = _background.bodyRect.centerRight.toVector2() -
        Vector2(padding / 2 - 5, 0) +
        Vector2(0, PurchaseItemBoardSelector.tabSectionHeight / 2)
    ..size = Vector2(_background.bodyRect.size.width / 1.8, _background.bodyRect.size.height) -
        Vector2.all(padding) -
        Vector2(0, PurchaseItemBoardSelector.tabSectionHeight)
    ..anchor = Anchor.centerRight;

  late final GoBackButton _backButton = GoBackButton(backFunction: onBackButtonPressed)
    ..position = _background.footerRect.center.toVector2() - Vector2(0, 5)
    ..anchor = Anchor.center;

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_shopTitleText);
    add(_goldIndicator);
    add(_healthIndicator);
    add(_purchaseTabs);
    add(_backButton);

    return super.onLoad();
  }

  void onBackButtonPressed() {
    closeDescriptionIfNeeded();

    parent.changeState(NextRoundHudState.menu);
  }

  void showDescription(Purchaseable purchaseable) {
    if (_shopItemDescription.isMounted && _shopItemDescription.selectedItemType == purchaseable.type) {
      return;
    }

    _shopItemDescription.itemSelected(purchaseable);
    add(_shopItemDescription);
  }

  void closeDescriptionIfNeeded() {
    if (_shopItemDescription.isMounted) {
      _shopItemDescription.removeFromParent();
    }
  }
}
