import 'package:defend_your_flame/core/flame/shop/purchaseable_category.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

abstract class Purchaseable {
  final Set<PurchaseableType> dependencies;

  final PurchaseableType type;
  final PurchaseableCategory category;

  final String name;
  final String description;
  final String quote;
  final List<int> cost;
  final int maxPurchaseCount;
  final bool comingSoon;

  int _purchaseCount = 0;

  bool get purchasedAnyAmount => _purchaseCount > 0;
  bool get purchasedMaxAmount => _purchaseCount >= maxPurchaseCount;
  int get purchaseCount => _purchaseCount;

  int get currentCost => _purchaseCount >= cost.length ? cost.last : cost[_purchaseCount];

  Purchaseable(
      {required this.type,
      required this.category,
      required this.name,
      required this.description,
      required this.quote,
      required this.cost,
      this.maxPurchaseCount = 1,
      this.dependencies = const {},
      this.comingSoon = false});

  void purchase(MainWorld world) {
    _purchaseCount++;
  }

  void reset() {
    _purchaseCount = 0;
  }
}
