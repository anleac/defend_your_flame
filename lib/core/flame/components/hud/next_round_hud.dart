import 'dart:async';

import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';

class NextRoundHud extends BasicHud {
  NextRoundHudState _state = DebugConstants.testShopLogic ? NextRoundHudState.shop : NextRoundHudState.menu;

  late final NextRoundMenuHud _menu = NextRoundMenuHud();
  late final MainShopHud _shop = MainShopHud();

  @override
  FutureOr<void> onLoad() {
    add(DebugConstants.testShopLogic ? _shop : _menu);
    return super.onLoad();
  }

  @override
  void reset() {
    for (var child in children) {
      if (child is BasicHud) {
        child.reset();
      }
    }

    changeState(DebugConstants.testShopLogic ? NextRoundHudState.shop : NextRoundHudState.menu);

    super.reset();
  }

  void changeState(NextRoundHudState state) {
    if (_state == state) return;
    _state = state;

    for (var child in children) {
      if (child is BasicHud) {
        child.removeFromParent();
      }
    }

    late BasicHud hudToShow;

    switch (_state) {
      case NextRoundHudState.menu:
        hudToShow = _menu;
        break;
      case NextRoundHudState.shop:
        hudToShow = _shop;
        break;
    }

    hudToShow.reset();
    add(hudToShow);
  }
}
