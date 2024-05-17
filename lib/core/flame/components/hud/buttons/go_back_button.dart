import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:flutter/material.dart';

class GoBackButton extends DefaultButton {
  final VoidCallback backFunction;

  GoBackButton({required this.backFunction}) : super();

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
