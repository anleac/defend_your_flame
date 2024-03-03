import 'dart:ui';

import 'package:defend_your_flame/core/flame/components/hud/level_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';

class RoundText extends TextComponent with ParentIsA<LevelHud>, HasGameReference<MainGame> {
  int _currentRound = 1;

  String get _roundText => game.appStrings.roundText(_currentRound);

  bool _visible = false;

  @override
  void update(double dt) {
    if (parent.currentRound != _currentRound) {
      _currentRound = parent.currentRound;
      text = _roundText;
    }

    _visible = !parent.roundOver;

    super.update(dt);
  }

  @override
  void renderTree(Canvas canvas) {
    if (_visible) {
      super.renderTree(canvas);
    }
  }
}
