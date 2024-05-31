import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GoBackButton extends DefaultButton {
  final VoidCallback backFunction;

  GoBackButton({required this.backFunction}) : super() {
    scale = Vector2.all(0.91);
  }

  @override
  void onMount() {
    text = game.appStrings.back;
    super.onMount();
  }

  @override
  void onPressed() {
    backFunction();
    super.onPressed();
  }
}
