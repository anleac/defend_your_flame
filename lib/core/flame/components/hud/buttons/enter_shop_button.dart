import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:flame/components.dart';

class EnterShopButton extends DefaultButton with ParentIsA<NextRoundMenuHud>, HasAncestor<NextRoundHud> {
  @override
  void onMount() {
    text = game.appStrings.enterShop;
    super.onMount();
  }

  @override
  void onPressed() {
    ancestor.changeState(NextRoundHudState.shop);
  }
}
