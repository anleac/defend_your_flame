import 'package:defend_your_flame/core/flame/components/hud/abstract_components/text_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class StartRoundButton extends TextButton with ParentIsA<NextRoundHud>, HasGameReference<MainGame> {
  StartRoundButton()
      : super(
          defaultTextRenderer: TextManager.smallHeaderRenderer,
          hoveredTextRenderer: TextManager.smallHeaderHoveredRenderer,
        );

  @override
  void onMount() {
    text = game.appStrings.startGame;
    super.onMount();
  }

  @override
  void onPressed() {
    text = game.appStrings.startRound;
    parent.startNextRound();
  }
}
