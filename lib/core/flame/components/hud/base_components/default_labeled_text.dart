import 'package:defend_your_flame/core/flame/components/hud/base_components/labeled_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';

class DefaultLabeledText extends LabeledText {
  DefaultLabeledText({super.label, super.text})
      : super(labelRenderer: TextManager.smallSubHeaderBoldRenderer, textRenderer: TextManager.basicHudRenderer);
}
