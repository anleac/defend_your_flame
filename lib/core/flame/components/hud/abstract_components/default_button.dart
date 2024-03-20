import 'package:defend_your_flame/core/flame/components/hud/abstract_components/text_button.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';

class DefaultButton extends TextButton {
  DefaultButton({super.text, super.underlined})
      : super(
          defaultTextRenderer: TextManager.smallHeaderRenderer,
          hoveredTextRenderer: TextManager.smallHeaderHoveredRenderer,
        );
}
