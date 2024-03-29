import 'package:defend_your_flame/core/flame/components/effects/text/floating_text.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/extensions.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class GoldText extends FloatingText {
  static final TextRenderer _goldTextRenderer =
      TextManager.customDefaultRenderer(fontSize: 10, color: Colors.yellow.darken(0.2));
  GoldText(int gold) : super(textRenderer: _goldTextRenderer) {
    scale = Vector2.all(1 + (gold / 20));
    text = "+$gold";
  }
}
