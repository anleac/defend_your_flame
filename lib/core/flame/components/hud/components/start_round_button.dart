import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class StartRoundButton extends TextBoxComponent
    with ParentIsA<LevelHud>, HasGameReference<MainGame>, TapCallbacks, HasVisibility {
  StartRoundButton()
      : super(
          text: '',
          anchor: Anchor.center,
          textRenderer: TextManager.smallHeaderRenderer,
          boxConfig: TextBoxConfig(timePerChar: 0.08),
        );

  @override
  void onMount() {
    text = game.appStrings.startGame;
    super.onMount();
  }

  @override
  void update(double dt) {
    isVisible = parent.roundOver;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final lineStart = Offset(-8, scaledSize.y / 2 + 15);
    final lineEnd = Offset(scaledSize.x - 20, scaledSize.y / 2 + 15);
    canvas.drawLine(lineStart, lineEnd, paint);
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    // Only on the first round do we want the start game text.
    text = game.appStrings.startRound;
    parent.startRound();
  }
}
