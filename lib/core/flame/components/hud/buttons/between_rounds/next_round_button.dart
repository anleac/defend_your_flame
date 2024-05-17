import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/next_round_internal/next_round_menu_hud.dart';
import 'package:flame/components.dart';

class NextRoundButton extends DefaultButton with ParentIsA<NextRoundMenuHud> {
  NextRoundButton() : super();

  @override
  void onMount() {
    text = game.appStrings.startRound;
    super.onMount();
  }

  @override
  void onPressed() {
    parent.startNextRound();
    super.onPressed();
  }
}
