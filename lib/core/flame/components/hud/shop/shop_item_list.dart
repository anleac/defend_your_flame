import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/shop/shop_item_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/horizontal_divider.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class ShopItemList extends PositionComponent with ParentIsA<MainShopHud>, HasWorldReference<MainWorld> {
  static const double shopItemHeight = 40;
  static const double padding = 10;

  late final BorderedBackground _background = BorderedBackground(hasFill: false)
    ..position = Vector2.zero()
    ..size = size;

  final List<ShopItemButton> _buttons = [];
  final List<HorizontalDivider> _dividers = [];

  @override
  Future<void> onLoad() async {
    add(_background);
    refresh();
    return super.onLoad();
  }

  @override
  void onMount() {
    refresh();
    super.onMount();
  }

  void refresh() {
    for (final button in _buttons) {
      button.removeFromParent();
    }
    for (final divider in _dividers) {
      divider.removeFromParent();
    }

    _buttons.clear();
    _dividers.clear();

    var visiblePurchases =
        world.shopManager.purchasables.where((p) => p.shouldBeVisible(world.shopManager.purchasedMap)).toList();

    var rollingButtonPosition = Vector2(size.x / 2, shopItemHeight / 2 + padding);
    var gap = Vector2(0, shopItemHeight + padding);
    _buttons.addAll(visiblePurchases.map((item) {
      final button = ShopItemButton(item)..position = rollingButtonPosition;
      rollingButtonPosition += gap;
      return button;
    }).toList());

    // Add a horizontal divider between each item
    for (var i = 0; i < _buttons.length; i++) {
      if (i > 0) {
        final divider = HorizontalDivider(padding: 15)
          ..position = Vector2(0, _buttons[i].position.y) - gap / 2
          ..size = Vector2(size.x, 2);
        _dividers.add(divider);
        add(divider);
      }

      add(_buttons[i]);
    }
  }
}
