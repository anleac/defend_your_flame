import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_description.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/shop_item_list.dart';
import 'package:defend_your_flame/core/flame/components/hud/sprite_with_texts/gold_indicator.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop/shop_title_text.dart';
import 'package:defend_your_flame/core/shop/purchasable.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class MainShopHud extends BasicHud with ParentIsA<NextRoundHud> {
  static const double _padding = 30;

  late final Vector2 _hudSize = Vector2(parent.world.worldWidth / 1.2, parent.world.worldHeight / 1.2);

  late final BorderedBackground _background = BorderedBackground()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 2)
    ..anchor = Anchor.center
    ..size = _hudSize;

  // Offset will be accurately represented by the top left position of the background, as it's the center of the HUD.
  late final Vector2 _offset = _background.topLeftPosition;

  // TODO: I'd like to create an abstract base component that has header/footer and a body, to make positioning a lot easier.
  // Perhaps we can re-vist this in the future if another HUD requires this. For now, for PoC, I'll add the logic here.
  static const double _headerFooterHeight = 80;
  late final Rect _headerRect = Rect.fromLTWH(_offset.x, _offset.y, _hudSize.x, _headerFooterHeight);
  late final Rect _footerRect =
      Rect.fromLTWH(_offset.x, _hudSize.y - _headerFooterHeight + _offset.y, _hudSize.x, _headerFooterHeight);

  late final Rect _bodyRect =
      Rect.fromLTWH(_offset.x, _headerFooterHeight + _offset.y, _hudSize.x, _hudSize.y - (_headerFooterHeight * 2));

  // In this case, the right body rectangle will take 2/3rds of the body, and the left will take 1/3rd.
  // This is because the right side will contain the description of the item, and the left will contain the shop items.
  late final Rect _rightBodyRect = Rect.fromLTWH(
    _bodyRect.right - _hudSize.x * 2 / 3 + _padding,
    _bodyRect.top,
    _hudSize.x * 2 / 3 - _padding * 2,
    _bodyRect.height,
  );

  late final Rect _leftBodyRect = Rect.fromLTWH(
    _bodyRect.left + _padding,
    _bodyRect.top,
    _hudSize.x / 3 - (_padding / 2), // Reduce the padding between the two rectangles internally.
    _bodyRect.height,
  );

  late final ShopTitleText _shopTitleText = ShopTitleText()
    ..position = _headerRect.center.toVector2()
    ..anchor = Anchor.center;

  late final GoldIndicator _goldIndicator = GoldIndicator()
    ..position = _headerRect.centerRight.toVector2() - Vector2(130, 15)
    ..scale = Vector2.all(1.5);

  late final ShopItemDescription _shopItemDescription = ShopItemDescription()
    ..position = _rightBodyRect.center.toVector2()
    ..anchor = Anchor.center
    ..size = _rightBodyRect.size.toVector2();

  late final ShopItemList _shopItemList = ShopItemList()
    ..position = _leftBodyRect.center.toVector2()
    ..anchor = Anchor.center
    ..size = _leftBodyRect.size.toVector2();

  late final GoBackButton _backButton = GoBackButton(backFunction: onBackButtonPressed)
    ..position = _footerRect.center.toVector2()
    ..anchor = Anchor.center;

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_shopItemList);
    add(_shopItemDescription);
    add(_shopTitleText);
    add(_goldIndicator);
    add(_backButton);

    return super.onLoad();
  }

  void onBackButtonPressed() {
    _shopItemDescription.itemSelected(null);
    parent.changeState(NextRoundHudState.menu);
  }

  void showItemDescription(Purchasable purchasable) {
    _shopItemDescription.itemSelected(purchasable);
  }
}