import 'dart:math';

import 'package:flame/components.dart';

mixin HasValueTimerAction on Component {
  double _timer = 0;
  double _timerTicker = 0;
  double _totalValueGiven = 0;
  double _totalValueToGive = 0;

  double _amountToGivePerEmission = 0;

  bool _timerActive = false;

  void startTimer({required double valueToGive, required double durationOver, double percentageToGiveOnEmission = 20}) {
    _resetValues();

    _amountToGivePerEmission = valueToGive * (percentageToGiveOnEmission / 100.0);
    _timerTicker = durationOver * (percentageToGiveOnEmission / 100.0);

    _totalValueToGive = valueToGive;
    _timerActive = true;
  }

  void emitValue(int valueToGive);

  void forceEndTimer({bool forceEmitIfNonZero = true}) {
    if (!_timerActive) {
      return;
    }

    _timerActive = false;
    var remainingValueToGive = _totalValueToGive - _totalValueGiven;
    if (forceEmitIfNonZero && remainingValueToGive > 0) {
      emitValue(remainingValueToGive.toInt());
    }
  }

  @override
  void update(double dt) {
    if (_timerActive) {
      _timer += dt;

      if (_timer >= _timerTicker) {
        _timer = 0;
        var toGive = min(_amountToGivePerEmission, _totalValueToGive - _totalValueGiven);
        _totalValueGiven += toGive;

        emitValue(toGive.toInt());

        if (_totalValueGiven >= _totalValueToGive) {
          _timerActive = false;
          _resetValues();
        }
      }
    }

    super.update(dt);
  }

  void _resetValues() {
    _timer = 0;
    _totalValueGiven = 0;
    _totalValueToGive = 0;
  }
}
