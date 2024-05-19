import 'dart:math';

import 'package:defend_your_flame/core/flame/components/effects/text/floating_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class FlameText extends FloatingText {
  static final TextRenderer _flameTextRenderer = TextManager.customDefaultRenderer(fontSize: 13, color: Colors.purple);
  FlameText(int toAdd) : super(textRenderer: _flameTextRenderer, upOnly: true) {
    scale = Vector2.all(_scaleFlameText(toAdd));
    text = "+$toAdd";
  }

  double _scaleFlameText(int health) {
    return 1 + (sqrt(health) / 4);
  }
}
