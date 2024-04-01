import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/enter_shop_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/next_round_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:flame/components.dart';

class NextRoundMenuHud extends BasicHud with ParentIsA<NextRoundHud> {
  late final NextRoundButton _nextRound = NextRoundButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4);

  late final EnterShopButton _enterShop = EnterShopButton()
    ..position = _nextRound.position + ThemingConstants.menuButtonGap;

  @override
  Future<void> onLoad() async {
    add(_nextRound);
    add(_enterShop);

    return super.onLoad();
  }

  void startNextRound() {
    world.roundManager.startNextRound();
  }
}
