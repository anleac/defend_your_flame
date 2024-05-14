import 'dart:math';

import 'package:defend_your_flame/core/flame/components/effects/text/floating_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class DamageText extends FloatingText {
  static final TextRenderer _damageTextRenderer = TextManager.customDefaultRenderer(fontSize: 14, color: Colors.red);
  DamageText(int damage) : super(textRenderer: _damageTextRenderer) {
    scale = Vector2.all(_scaleDamageText(damage));
    text = "-$damage";
  }

  double _scaleDamageText(int dmg) {
    return 1 + (sqrt(dmg) / 6);
  }
}
