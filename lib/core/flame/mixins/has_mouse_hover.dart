import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

mixin HasMouseHover on HoverCallbacks, HasGameReference<MainGame> {
  MouseCursor _hoverCursor = SystemMouseCursors.click;

  setHoverCursor(MouseCursor cursor) => _hoverCursor = cursor;

  @override
  @mustCallSuper
  void onHoverEnter() {
    game.mouseCursor = _hoverCursor;
    super.onHoverEnter();
  }

  @override
  @mustCallSuper
  void onHoverExit() {
    resetCursor();
    super.onHoverExit();
  }

  resetCursor() {
    game.mouseCursor = SystemMouseCursors.basic;
  }
}
