// A class to hold effect components, such as damage text, particles, etc.
// This helps to keep it separate from the main game logic and allows for easy management of effects.
import 'package:defend_your_flame/core/flame/components/effects/damage_text.dart';
import 'package:flame/components.dart';

class EffectManager extends PositionComponent {
  addDamageText(int damage, Vector2 position) {
    add(DamageText(damage.toString())..position = position);
  }
}
