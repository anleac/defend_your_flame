import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:flame/components.dart';

class FastTrackToButton extends DefaultButton with ParentIsA<GameSelectionHud> {
  final int round;
  final int gold;

  FastTrackToButton({required this.round, required this.gold}) : super();

  @override
  void onMount() {
    text = AppStringHelper.insertNumber(game.appStrings.fastTrackTo, round);
    super.onMount();
  }

  @override
  void onPressed() {
    parent.startGame(gold: gold, round: round);
  }
}
