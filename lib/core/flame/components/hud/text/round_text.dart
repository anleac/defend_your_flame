import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class RoundText extends DefaultText with HasWorldReference<MainWorld> {
  int _currentRound = 0;

  String get _roundText => game.appStrings.roundText(_currentRound);
  String get _endOfRoundText => game.appStrings.endOfRoundText(_currentRound);

  final bool betweenRoundsHud;

  RoundText({required this.betweenRoundsHud})
      : super(textRenderer: TextManager.headerRenderer, anchor: Anchor.topCenter);

  @override
  void onMount() {
    position = Vector2(world.worldWidth / 2, 10);
    super.onMount();
  }

  @override
  void update(double dt) {
    if (world.roundManager.currentRound != _currentRound) {
      _currentRound = world.roundManager.currentRound;
      text = betweenRoundsHud ? _endOfRoundText : _roundText;
    }

    super.update(dt);
  }
}
