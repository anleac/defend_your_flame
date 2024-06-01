import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/board/purchase_item_board_selector.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:flame/components.dart';

class PurchaseItemBoardTab extends DefaultButton with ParentIsA<PurchaseItemBoardSelector> {
  final PurchaseableCategory tab;

  PurchaseItemBoardTab({required this.tab, super.comingSoon}) : super(underliningEnabled: false) {
    scale = Vector2.all(0.92);
  }

  @override
  FutureOr<void> onLoad() {
    text = tab.name;
    return super.onLoad();
  }

  @override
  void onPressed() {
    parent.changeTab(tab);
    super.onPressed();
  }
}
