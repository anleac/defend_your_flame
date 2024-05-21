import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

mixin HasMouseHover on HoverCallbacks, HasGameReference<MainGame> {
  bool canHover = true;
  MouseCursor _hoverCursor = SystemMouseCursors.click;

  setHoverCursor(MouseCursor cursor) => _hoverCursor = cursor;

  @override
  @mustCallSuper
  void onHoverEnter() {
    if (!canHover) return;

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

  changeHoverStatus({required bool canHover}) {
    this.canHover = canHover;
    if (!canHover) {
      resetCursor();
    }
  }
}
