import 'package:defend_your_flame/core/flame/components/hud/abstract_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/shop_title_text.dart';
import 'package:flame/components.dart';

class NextRoundShopHud extends BasicHud with ParentIsA<NextRoundHud> {
  late final ShopTitleText _shopTitleText = ShopTitleText()
    ..position = Vector2(world.worldWidth / 2, 15)
    ..anchor = Anchor.topCenter;

  late final GoBackButton _backButton = GoBackButton(backFunction: onBackButtonPressed)
    ..position = Vector2(world.worldWidth / 2, world.worldHeight - 100);

  @override
  Future<void> onLoad() async {
    add(_shopTitleText);
    add(_backButton);

    return super.onLoad();
  }

  void onBackButtonPressed() {
    parent.changeState(NextRoundHudState.menu);
  }
}
