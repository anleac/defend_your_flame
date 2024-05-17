import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

mixin HasMouseDrag on TapCallbacks, DragCallbacks, HasGameReference<MainGame> {
  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    setCursor();
  }

  @override
  @mustCallSuper
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    setCursor();
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    resetCursor();
  }

  @override
  @mustCallSuper
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    resetCursor();
  }

  @override
  @mustCallSuper
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    resetCursor();
  }

  void setCursor() {
    game.mouseCursor = SystemMouseCursors.grabbing;
  }

  void resetCursor() {
    game.mouseCursor = SystemMouseCursors.basic;
  }
}
