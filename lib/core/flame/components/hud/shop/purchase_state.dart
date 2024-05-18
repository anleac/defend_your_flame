import 'package:flutter/material.dart';

enum PurchaseState {
  purchased,
  cantAfford,
  canPurchase,
  missingDependencies,
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
    }
  }
}
