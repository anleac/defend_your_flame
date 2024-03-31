import 'package:defend_your_flame/core/flame/components/hud/abstract_components/text_button.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class DefaultButton extends TextButton with HasGameReference<MainGame> {
  DefaultButton({super.text, super.underlined, super.comingSoon})
      : super(
          defaultTextRenderer: TextManager.smallHeaderRenderer,
          hoveredTextRenderer: TextManager.smallHeaderHoveredRenderer,
          disabledRenderer: TextManager.smallHeaderDisabledRenderer,
          anchor: Anchor.center,
        );
}
