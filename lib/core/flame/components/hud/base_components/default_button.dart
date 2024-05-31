import 'package:defend_your_flame/core/flame/components/hud/base_components/text_button.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/components.dart';

class DefaultButton extends TextButton {
  DefaultButton({super.text, super.underlined, super.comingSoon})
      : super(
          defaultTextRenderer: TextManager.smallHeaderRenderer,
          anchor: Anchor.center,
        );
}
