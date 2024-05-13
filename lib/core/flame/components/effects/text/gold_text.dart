import 'dart:math';

import 'package:defend_your_flame/core/flame/components/effects/text/floating_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/extensions.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class GoldText extends FloatingText {
  static final TextRenderer _goldTextRenderer =
      TextManager.customDefaultRenderer(fontSize: 10, color: Colors.yellow.darken(0.15));
  GoldText(int gold) : super(textRenderer: _goldTextRenderer) {
    scale = Vector2.all(_scaleGoldText(gold));
    text = "+$gold";
  }

  double _scaleGoldText(int gold) {
    return 1 + (sqrt(gold) / 5);
  }
}
