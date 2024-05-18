import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/mixins/has_purchase_status.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/purchase_state.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PurchaseItem extends PositionComponent
    with
        HoverCallbacks,
        HasGameReference<MainGame>,
        TapCallbacks,
        HasMouseHover,
        HasAncestor<MainShopHud>,
        HasWorldReference<MainWorld>,
        HasPurchaseStatus {
  static const double rectangleWidthAndHeight = 65;

  late final BorderedBackground _borderedBackground = BorderedBackground(borderRadius: 8, borderThickness: 2.5)
    ..size = size;
  late final DefaultText _title = DefaultText(text: purchaseable.name.substring(0, 1), anchor: Anchor.topCenter)
    ..position = size / 2
    ..anchor = Anchor.center;

  final Purchaseable purchaseable;

  PurchaseItem(this.purchaseable) {
    size = Vector2.all(rectangleWidthAndHeight);
    initPurchaseState(purchaseable);
  }

  @override
  FutureOr<void> onLoad() {
    add(_borderedBackground);
    add(_title);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO revisit post beta, this isn't the most efficient usage of a snapshot
    _borderedBackground.overrideBorderColour(purchaseState.color.withOpacity(0.7));
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    ancestor.showDescription(purchaseable);
    super.onTapDown(event);
  }
}
