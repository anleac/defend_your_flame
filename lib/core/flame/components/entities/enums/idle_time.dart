enum IdleTime {
  none,
  short,
  medium,
  long,
}

extension IdleTimeExtension on IdleTime {
  double get timeScale {
    switch (this) {
      case IdleTime.none:
        return 0;
      case IdleTime.short:
        return 0.5;
      case IdleTime.medium:
        return 1;
      case IdleTime.long:
        return 1.5;
    }
  }
}
