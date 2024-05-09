import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';

mixin HasIdleTime on Entity {
  late double _nextIdleTimeInSeconds = _calculateNextIdleTimeInSeconds();
  double _idleTimer = 0.0;

  double _calculateNextIdleTimeInSeconds() {
    var baseIdleTime = GlobalVars.rand.nextDouble() * 1.5 + 1.5;
    return baseIdleTime * idleTime.timeScale;
  }

  void shiftStateFromIdle({bool shortDuration = false}) {
    if (idleTime == IdleTime.none) {
      return;
    }

    if (current == EntityState.idle) {
      current = EntityState.walking;
    } else if (current == EntityState.walking) {
      current = EntityState.idle;
    }

    _idleTimer = 0.0;
    _nextIdleTimeInSeconds = _calculateNextIdleTimeInSeconds();

    if (shortDuration) {
      _nextIdleTimeInSeconds /= 6;
    }
  }

  void forceResetIdleTimer() {
    _idleTimer = 0.0;
  }

  @override
  void update(double dt) {
    if (idleTime != IdleTime.none) {
      _idleTimer += dt;

      if (_idleTimer >= _nextIdleTimeInSeconds) {
        shiftStateFromIdle();
      }
    }

    super.update(dt);
  }
}
