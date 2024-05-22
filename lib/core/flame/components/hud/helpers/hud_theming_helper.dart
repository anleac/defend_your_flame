import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:flame/rendering.dart';

class HudThemingHelper {
  static final PaintDecorator _disabledDecorator = PaintDecorator.tint(ThemingConstants.disabledTint);
  static PaintDecorator get disabledDecorator => _disabledDecorator;
}
