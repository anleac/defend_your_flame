import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class TipText extends PositionComponent with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  static const double padding = 15;

  late final TextComponent _tipText = TextComponent(textRenderer: TextManager.basicHudItalicRenderer)
    ..anchor = Anchor.center;

  late final BorderedBackground _background = BorderedBackground()..anchor = Anchor.center;

  String _currentTipText = '';
  int _currentRound = -1;

  @override
  Future<void> onLoad() async {
    add(_background);
    add(_tipText);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (world.roundManager.currentRound != _currentRound) {
      _currentRound = world.roundManager.currentRound;
      _setTip(game.appStrings.getRandomTip());
    }

    super.update(dt);
  }

  _setTip(String tip) {
    if (_currentTipText != tip) {
      _currentTipText = tip;
      _tipText.text = tip;
      _background.updateSize(_tipText.scaledSize + Vector2.all(padding * 2));
    }
  }
}
