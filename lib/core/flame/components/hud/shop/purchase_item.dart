import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PurchaseItem extends PositionComponent
    with HoverCallbacks, HasGameReference<MainGame>, TapCallbacks, HasMouseHover, HasAncestor<MainShopHud> {
  static const double rectangleWidthAndHeight = 65;

  late final BorderedBackground _borderedBackground = BorderedBackground(borderRadius: 8, borderThickness: 3)
    ..size = size;
  late final DefaultText _title = DefaultText(text: purchaseable.name.substring(0, 1), anchor: Anchor.topCenter)
    ..position = size / 2
    ..anchor = Anchor.center;

  final Purchaseable purchaseable;

  PurchaseItem(this.purchaseable) {
    size = Vector2.all(rectangleWidthAndHeight);
  }

  @override
  FutureOr<void> onLoad() {
    add(_borderedBackground);
    add(_title);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    ancestor.showDescription(purchaseable);
    super.onTapDown(event);
  }
}
