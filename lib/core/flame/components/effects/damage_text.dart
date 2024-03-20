import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';

class DamageText extends TextComponent {
  static const double speed = 0.5;

  late Vector2 _velocity = Vector2((GlobalVars.rand.nextDouble() * speed) * (GlobalVars.rand.nextBool() ? 1 : -1),
          -((GlobalVars.rand.nextDouble() * speed) + (1.5 * speed)).abs()) *
      0.2;

  DamageText(String text) : super(text: text, textRenderer: TextManager.tinyRenderer);

  @override
  void update(double dt) {
    _velocity = TimestepHelper.multiplyVector2(_velocity, 0.95, dt);
    position += _velocity;
    var newScale = TimestepHelper.add(scale.x, -0.8, dt);
    scale = Vector2.all(newScale);

    if (scale.x < 0.04) {
      removeFromParent();
    }

    super.update(dt);
  }
}
