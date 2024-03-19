import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class GameOverText extends TextComponent with ParentIsA<LevelHud>, HasGameReference<MainGame>, HasVisibility {
  GameOverText() : super(text: '', anchor: Anchor.center, textRenderer: TextManager.smallHeaderRenderer);

  @override
  void onMount() {
    text = game.appStrings.gameOver;
    super.onMount();
  }

  @override
  void update(double dt) {
    isVisible = parent.gameOver;
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point);
  }
}
