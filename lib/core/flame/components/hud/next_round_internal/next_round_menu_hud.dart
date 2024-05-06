import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/between_rounds/enter_shop_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/between_rounds/next_round_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/between_rounds/save_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/tip_text.dart';
import 'package:flame/components.dart';

class NextRoundMenuHud extends BasicHud with ParentIsA<NextRoundHud> {
  late final NextRoundButton _nextRound = NextRoundButton()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3);

  late final EnterShopButton _enterShop = EnterShopButton()
    ..position = _nextRound.position + ThemingConstants.menuButtonGap;

  late final SaveGameButton _saveGameButton = SaveGameButton()
    ..position = _enterShop.position + ThemingConstants.menuButtonGap;

  late final LevelHud _levelHud = LevelHud(betweenRoundsHud: true);

  late final TipText _tipText = TipText()..position = Vector2(world.worldWidth / 2, world.worldHeight - 120);

  @override
  Future<void> onLoad() async {
    add(_nextRound);
    add(_enterShop);
    add(_saveGameButton);
    add(_levelHud);
    add(_tipText);

    return super.onLoad();
  }

  void startNextRound() {
    world.roundManager.startNextRound();
  }
}
