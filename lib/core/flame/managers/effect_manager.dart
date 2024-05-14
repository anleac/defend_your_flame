// A class to hold effect components, such as damage text, particles, etc.
// This helps to keep it separate from the main game logic and allows for easy management of effects.
import 'package:defend_your_flame/core/flame/components/effects/text/damage_text.dart';
import 'package:defend_your_flame/core/flame/components/effects/text/gold_text.dart';
import 'package:defend_your_flame/core/flame/components/effects/text/health_text.dart';
import 'package:flame/components.dart';

class EffectManager extends PositionComponent {
  addDamageText(int damage, Vector2 position) {
    add(DamageText(damage)..position = position);
  }

  addGoldText(int gold, Vector2 position) {
    add(GoldText(gold)..position = position);
  }

  void addHealthText(int totalToRepair, Vector2 position) {
    add(HealthText(totalToRepair)..position = position);
  }
}
