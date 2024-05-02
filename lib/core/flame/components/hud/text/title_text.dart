import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';

class TitleText extends TextComponent {
  TitleText() : super(text: Constants.gameTitle, textRenderer: TextManager.largeHeaderRenderer);
}
