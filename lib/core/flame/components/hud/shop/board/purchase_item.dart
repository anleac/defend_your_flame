import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/mixins/has_purchase_status.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_state.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/rendering.dart';

class PurchaseItem extends PositionComponent
    with
        HoverCallbacks,
        HasGameReference<MainGame>,
        TapCallbacks,
        HasMouseHover,
        HasAncestor<MainShopHud>,
        HasWorldReference<MainWorld>,
        HasPurchaseStatus {
  static const double rectangleHeight = 46;
  static const double rectangleWidth = 220;

  late final BorderedBackground _borderedBackground = BorderedBackground(borderRadius: 8, borderThickness: 2.5)
    ..size = size;
  late final DefaultText _title = DefaultText(text: purchaseable.name, anchor: Anchor.topCenter)
    ..position = size / 2
    ..anchor = Anchor.center;

  final Purchaseable purchaseable;

  PurchaseItem(this.purchaseable) {
    size = Vector2(rectangleWidth, rectangleHeight);
    initPurchaseState(purchaseable);
  }

  @override
  FutureOr<void> onLoad() {
    add(_borderedBackground);
    add(_title);
    return super.onLoad();
  }

  @override
  void onStateChange(PurchaseState updatedState) {
    _borderedBackground.overrideBorderColour(updatedState.opaqueColor);
    _title.decorator.replaceLast(PaintDecorator.tint(updatedState.opaqueColor));
    super.onStateChange(updatedState);
  }

  @override
  void onTapDown(TapDownEvent event) {
    ancestor.showDescription(purchaseable);
    super.onTapDown(event);
  }
}
