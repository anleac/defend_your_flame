import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:flame/components.dart';

class VersionText extends TextComponent {
  VersionText() : super(text: VersioningConstants.version, scale: Vector2.all(0.7));
}
