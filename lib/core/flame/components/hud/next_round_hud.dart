import 'dart:async';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/abstract_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/enter_shop_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/next_round_button.dart';
import 'package:flame/components.dart';

class NextRoundHud extends BasicHud {
  late final NextRoundButton _nextRound = NextRoundButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 4);

  late final EnterShopButton _enterShop = EnterShopButton()
    ..position = _nextRound.position + ThemingConstants.menuButtonGap;

  @override
  FutureOr<void> onLoad() {
    add(_nextRound);
    add(_enterShop);
    return super.onLoad();
  }

  void startNextRound() {
    world.roundManager.startNextRound();
  }
}
