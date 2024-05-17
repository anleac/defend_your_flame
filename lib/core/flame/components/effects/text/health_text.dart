import 'dart:math';

import 'package:defend_your_flame/core/flame/components/effects/text/floating_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class HealthText extends FloatingText {
  static final TextRenderer _damageTextRenderer = TextManager.customDefaultRenderer(fontSize: 13, color: Colors.green);
  HealthText(int health) : super(textRenderer: _damageTextRenderer) {
    scale = Vector2.all(_scaleHealthText(health));
    text = "+$health";
  }

  double _scaleHealthText(int health) {
    return 1 + (sqrt(health) / 3);
  }
}
