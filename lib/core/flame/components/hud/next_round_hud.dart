import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/stateful_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/shop/main_shop_hud.dart';

class NextRoundHud extends StatefulHud<NextRoundHudState> {
  late final NextRoundMenuHud _menu = NextRoundMenuHud();
  late final MainShopHud _shop = MainShopHud();

  NextRoundHud() {
    init(DebugConstants.testShopLogic ? NextRoundHudState.shop : NextRoundHudState.menu, {
      NextRoundHudState.menu: _menu,
      NextRoundHudState.shop: _shop,
    });
  }
}
