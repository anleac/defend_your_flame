enum TimeSpendIdle {
  none,
  minimal,
  moderate,
  often,
}

extension IdleTimeExtension on TimeSpendIdle {
  double get timeScale {
    switch (this) {
      case TimeSpendIdle.none:
        return 0;
      case TimeSpendIdle.minimal:
        return 2;
      case TimeSpendIdle.moderate:
        return 1.5;
      case TimeSpendIdle.often:
        return 1;
    }
  }
}
