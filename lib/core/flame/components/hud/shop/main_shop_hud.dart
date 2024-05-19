import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/default_hud_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_item_board.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/gold_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/health_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/shop_title_text.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class MainShopHud extends BasicHud with ParentIsA<NextRoundHud> {
  static const double padding = 30;
  static const double bodyHorizontalPadding = 20;
  static const double headerHeight = 66;
  static const double footerHeight = 50;

  static const double clippingBoardPadding = 6;

  late final DefaultHudBackground _background = DefaultHudBackground(world: world);

  // Offset will be accurately represented by the top left position of the background, as it's the center of the HUD.
  late final Vector2 _offset = _background.topLeftPosition;

  // TODO: I'd like to create an abstract base component that has header/footer and a body, to make positioning a lot easier.
  // Perhaps we can re-vist this in the future if another HUD requires this. For now, for PoC, I'll add the logic here.
  late final Rect _headerRect = Rect.fromLTWH(_offset.x, _offset.y, _background.size.x, headerHeight);

  late final Rect _bodyRect = Rect.fromLTWH(_offset.x + bodyHorizontalPadding, headerHeight + _offset.y,
      _background.size.x - (bodyHorizontalPadding * 2), _background.size.y - (headerHeight + footerHeight));

  late final Rect _footerRect = Rect.fromLTWH(_offset.x, _bodyRect.bottom, _background.size.x, footerHeight);

  late final ShopTitleText _shopTitleText = ShopTitleText()
    ..position = _headerRect.center.toVector2()
    ..anchor = Anchor.center;

  late final GoldIndicator _goldIndicator = GoldIndicator()
    ..position = _headerRect.centerRight.toVector2() - Vector2(padding, 0)
    ..anchor = Anchor.centerRight
    ..scale = Vector2.all(1.5);

  late final HealthIndicator _healthIndicator = HealthIndicator()
    ..position = _headerRect.centerLeft.toVector2() + Vector2(padding, 0)
    ..anchor = Anchor.centerLeft
    ..scale = _goldIndicator.scale;

  late final BorderedBackground _bodyBackground = BorderedBackground(hasFill: false)
    ..position = _bodyRect.center.toVector2()
    ..anchor = Anchor.center
    ..size = _bodyRect.size.toVector2();

  late final PurchaseItemBoard _purchaseItemBoard = PurchaseItemBoard(world.shopManager.purchasables)
    ..size = _bodyRect.size.toVector2()
    ..anchor = Anchor.topLeft;

  late final ClipComponent _clippedPurchaseItemBoard = ClipComponent.rectangle(
    position: _bodyRect.topLeft.toVector2() + Vector2.all(clippingBoardPadding),
    size: _purchaseItemBoard.size - Vector2.all(clippingBoardPadding * 2),
    children: [_purchaseItemBoard],
  );

  late final ShopItemDescription _shopItemDescription = ShopItemDescription()
    ..position = _bodyRect.centerRight.toVector2() - Vector2(padding / 2, 0)
    ..size = Vector2(_bodyRect.size.width / 1.56, _bodyRect.size.height) - Vector2.all(padding)
    ..anchor = Anchor.centerRight;

  late final GoBackButton _backButton = GoBackButton(backFunction: onBackButtonPressed)
    ..position = _footerRect.center.toVector2()
    ..anchor = Anchor.center;

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_bodyBackground);
    add(_shopTitleText);
    add(_goldIndicator);
    add(_healthIndicator);
    add(_backButton);

    add(_clippedPurchaseItemBoard);

    return super.onLoad();
  }

  void onBackButtonPressed() {
    if (_shopItemDescription.isMounted) {
      _shopItemDescription.removeFromParent();
    }

    parent.changeState(NextRoundHudState.menu);
  }

  void showDescription(Purchaseable purchaseable) {
    if (_shopItemDescription.isMounted && _shopItemDescription.selectedItemType == purchaseable.type) {
      return;
    }

    _shopItemDescription.itemSelected(purchaseable);
    add(_shopItemDescription);
  }
}
