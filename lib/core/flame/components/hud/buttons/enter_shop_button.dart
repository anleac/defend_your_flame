import 'package:defend_your_flame/core/flame/components/hud/abstract_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class EnterShopButton extends DefaultButton with ParentIsA<NextRoundHud>, HasGameReference<MainGame> {
  EnterShopButton() : super(comingSoon: true);

  @override
  void onMount() {
    text = game.appStrings.enterShop;
    super.onMount();
  }

  @override
  void onPressed() {
    // TODO - load a game!
  }
}
