import 'package:defend_your_flame/helpers/global_vars.dart';
import 'package:defend_your_flame/helpers/timestep/timestep_helper.dart';
import 'package:flame/components.dart';

class FloatingText extends TextComponent {
  static const double speed = 30;

  late Vector2 _velocity = Vector2(
    GlobalVars.rand.nextDouble() * 2 * speed - speed,
    GlobalVars.rand.nextDouble() * 2 * speed - speed,
  );

  double _timeAlive = 0;

  FloatingText({super.text, super.textRenderer}) {
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    _timeAlive += dt;
    _velocity = TimestepHelper.multiplyVector2(_velocity, 0.95, dt);
    position = TimestepHelper.addVector2(position, _velocity, dt);

    var newScale = TimestepHelper.add(scale.x, -0.7 - (_timeAlive * 2), dt);
    scale = Vector2.all(newScale);

    if (scale.x < 0.04) {
      removeFromParent();
    }

    super.update(dt);
  }
}
