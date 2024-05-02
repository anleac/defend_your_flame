import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';

class DefaultText extends TextComponent with HasGameReference<MainGame> {
  DefaultText({String text = '', Anchor anchor = Anchor.center, TextRenderer? textRenderer})
      : super(text: text, anchor: anchor, textRenderer: textRenderer ?? TextManager.defaultRenderer);
}
