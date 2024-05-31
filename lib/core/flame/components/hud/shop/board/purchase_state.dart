import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

enum PurchaseState {
  purchased,
  cantAfford,
  canPurchase,
  missingDependencies,
  conflictingPurchase,
}

extension PurchaseStateExtension on PurchaseState {
  Color get color {
    switch (this) {
      case PurchaseState.purchased:
        return Colors.green;
      case PurchaseState.cantAfford:
        return Colors.red;
      case PurchaseState.canPurchase:
        return Colors.white;
      case PurchaseState.missingDependencies:
        return Colors.yellow;
      case PurchaseState.conflictingPurchase:
        return Colors.grey.darken(0.5);
    }
  }

  Color get opaqueColor {
    return color.withOpacity(0.7);
  }

  Color get lightenedColor {
    return color.brighten(0.3);
  }
}
