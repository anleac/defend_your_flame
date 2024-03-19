import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:flame/components.dart';

class VersionText extends TextComponent {
  VersionText() : super(text: VersioningConstants.version, textRenderer: TextManager.basicHudRenderer);
}
