import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:flutter/material.dart';

class GoForwardButton extends DefaultButton {
  final VoidCallback forwardFunction;

  GoForwardButton({required this.forwardFunction}) : super();

  @override
  void onMount() {
    text = game.appStrings.continueText;
    super.onMount();
  }

  @override
  void onPressed() {
    forwardFunction();
    super.onPressed();
  }
}
