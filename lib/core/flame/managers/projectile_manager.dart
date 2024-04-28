// A class to hold effect components, such as damage text, particles, etc.
// This helps to keep it separate from the main game logic and allows for easy management of effects.
import 'package:flame/components.dart';

class ProjectileManager extends PositionComponent {
  addProjectile(Component projectile) {
    add(projectile);
  }

  void clearAllProjectiles() {
    for (final projectile in children) {
      projectile.removeFromParent();
    }
  }
}
