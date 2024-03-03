import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class StartRound extends TextComponent with ParentIsA<LevelHud>, HasGameReference<MainGame>, TapCallbacks {
  bool _visible = false;

  StartRound() : super(text: '', anchor: Anchor.center, scale: Vector2.all(1.2));

  @override
  void onMount() {
    text = game.appStrings.startGame;
    super.onMount();
  }

  @override
  void update(double dt) {
    _visible = parent.roundOver;
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return _visible && super.containsLocalPoint(point);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    // Only on the first round do we want the start game text.
    text = game.appStrings.startRound;
    parent.startRound();
  }

  @override
  void renderTree(Canvas c) {
    if (_visible) {
      super.renderTree(c);
    }
  }
}
