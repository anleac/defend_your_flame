import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/enums/idle_time.dart';
import 'package:defend_your_flame/helpers/global_vars.dart';

mixin HasIdleTime on Entity {
  late double _nextIdleTimeInSeconds = _calculateNextIdleTimeInSeconds();
  late double _timeToSpendIdleInSeconds = _calculateTimeToSpendIdleInSeconds();

  double _idleTimer = 0.0;

  double _calculateNextIdleTimeInSeconds() {
    var baseIdleTime = GlobalVars.rand.nextDouble() * 2 + 2.5;
    return baseIdleTime * idleTime.timeScale;
  }

  double _calculateTimeToSpendIdleInSeconds() {
    var baseIdleTime = GlobalVars.rand.nextDouble() * 1.5 + 3;
    return baseIdleTime / idleTime.timeScale;
  }

  toggleToIdle({bool shortDuration = false}) {
    if (idleTime == TimeSpendIdle.none) {
      return;
    }

    if (current == EntityState.walking) {
      current = EntityState.idle;
      _timeToSpendIdleInSeconds = _calculateTimeToSpendIdleInSeconds();
    }

    _idleTimer = 0.0;

    if (shortDuration) {
      _timeToSpendIdleInSeconds /= 6;
    }
  }

  void toggleToWalking({bool shortDuration = false}) {
    if (idleTime == TimeSpendIdle.none) {
      return;
    }

    if (current == EntityState.idle) {
      current = EntityState.walking;
      _nextIdleTimeInSeconds = _calculateNextIdleTimeInSeconds();
    }
  }

  void forceResetIdleTimer() {
    _idleTimer = 0.0;
  }

  @override
  void update(double dt) {
    if (idleTime != TimeSpendIdle.none) {
      _idleTimer += dt;

      if (current == EntityState.walking && _idleTimer >= _nextIdleTimeInSeconds) {
        toggleToIdle();
      } else if (current == EntityState.idle && _idleTimer >= _timeToSpendIdleInSeconds) {
        toggleToWalking();
      }

      // If they were picked up and dropped, we should reset this.
      if (current == EntityState.falling) {
        forceResetIdleTimer();
      }
    }

    super.update(dt);
  }
}
