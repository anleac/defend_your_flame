import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/horizontal_divider.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_item_board.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_item_board_tab.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PurchaseItemBoardSelector extends PositionComponent
    with TapCallbacks, HasWorldReference<MainWorld>, HasAncestor<MainShopHud> {
  static const double tabPadding = 25;

  final Map<PurchaseableCategory, PurchaseItemBoardTab> _tabs = {};
  final Map<PurchaseableCategory, PurchaseItemBoard> _boards = {};
  PurchaseableCategory _currentTab = PurchaseableCategory.walls;

  PurchaseItemBoardSelector();

  @override
  FutureOr<void> onLoad() {
    Vector2 runningTabPosition = Vector2(tabPadding, tabPadding / 2);

    add(HorizontalDivider(padding: 5)
      ..size = Vector2(size.x, 2)
      ..position = Vector2(0, tabPadding * 2.3));

    for (var tabType in PurchaseableCategory.values) {
      final tab = PurchaseItemBoardTab(tab: tabType, comingSoon: tabType == PurchaseableCategory.spells)
        ..anchor = Anchor.topLeft;
      tab.position = runningTabPosition;

      _tabs.putIfAbsent(tabType, () => tab);
      add(tab);

      runningTabPosition += Vector2(tab.width + tabPadding * 2, 0);

      var purchasables = world.shopManager.getPurchaseablesByCategory(tabType);
      var verticalOffset = tab.height + tabPadding * 2;
      // TODO fix this drag mechanic
      var board = PurchaseItemBoard(purchasables, Vector2(0, verticalOffset * 1.5))
        ..size = size - Vector2(0, verticalOffset * 2);
      _boards.putIfAbsent(tabType, () => board);
    }

    add(_boards[_currentTab]!);
    _tabs[_currentTab]!.setSelected(true);

    return super.onLoad();
  }

  void changeTab(PurchaseableCategory tab) {
    if (_currentTab == tab) {
      return;
    }

    ancestor.closeDescriptionIfNeeded();

    _boards[_currentTab]!.removeFromParent();
    _tabs[_currentTab]!.setSelected(false);

    _currentTab = tab;
    _tabs[_currentTab]!.setSelected(true);

    add(_boards[_currentTab]!);
  }
}
