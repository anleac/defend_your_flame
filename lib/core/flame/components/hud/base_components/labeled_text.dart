import 'dart:async';

import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';

class LabeledText extends PositionComponent with HasGameReference<MainGame> {
  final String label;
  String text;

  final TextRenderer labelRenderer;
  final TextRenderer textRenderer;

  late final TextComponent _labelText = TextComponent(text: label)
    ..textRenderer = labelRenderer
    ..anchor = Anchor.topLeft
    ..position = Vector2(0, 0);

  late final TextComponent _textText = TextComponent(text: text)
    ..textRenderer = textRenderer
    ..anchor = Anchor.centerLeft;

  LabeledText({
    this.label = '',
    this.text = '',
    required this.labelRenderer,
    required this.textRenderer,
  });

  @override
  FutureOr<void> onLoad() {
    add(_labelText);
    add(_textText);
    _setTitlePosition();
    return super.onLoad();
  }

  setLabel(String newLabel) {
    _labelText.text = newLabel;
    // If this changes, we need to update the position of the text.
    _setTitlePosition();
  }

  void updateText(String newText) {
    _textText.text = newText;
  }

  _setTitlePosition() {
    _textText.position = _labelText.scaledSize + Vector2(10, -_labelText.scaledSize.y / 2);
  }
}
