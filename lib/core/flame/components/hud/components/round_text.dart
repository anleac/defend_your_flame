import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class RoundText extends TextComponent  with ParentIsA<MainWorld> {
  VersionText() : super(text: VersioningConstants.version, scale: Vector2.all(0.7));
}
