enum FlameType {
  basic,
  strong,
  manaProducing,
  totemEnhancing,
}

extension FlameTypeExtension on FlameType {
  double get scale {
    switch (this) {
      case FlameType.basic:
        return 1;
      case FlameType.strong:
        return 1.15;
      case FlameType.manaProducing:
        return 1.25;
      case FlameType.totemEnhancing:
        return 1.2;
    }
  }

  double get manaOutput {
    switch (this) {
      case FlameType.basic:
        return 1;
      case FlameType.totemEnhancing:
      case FlameType.strong:
        return 1.2;
      case FlameType.manaProducing:
        return 2;
    }
  }

  double get totemIncrease {
    switch (this) {
      case FlameType.basic:
        return 1;
      case FlameType.totemEnhancing:
        return 1.4;
      case FlameType.strong:
      case FlameType.manaProducing:
        return 1.1;
    }
  }
}
