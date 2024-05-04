import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

abstract class Purchasable {
  final Set<Type> dependencies;

  final String name;
  final String description;
  final String quote;
  final int cost;
  final int maxPurchaseCount;
  final bool comingSoon;

  int _purchaseCount = 0;

  bool get purchasedAnyAmount => _purchaseCount > 0;
  bool get purchasedMaxAmount => _purchaseCount >= maxPurchaseCount;
  int get purchaseCount => _purchaseCount;

  Purchasable(
      {required this.name,
      required this.description,
      required this.quote,
      required this.cost,
      this.maxPurchaseCount = 1,
      this.dependencies = const {},
      this.comingSoon = false});

  void purchase(MainWorld world) {
    _purchaseCount++;
  }

  // TODO post-beta release: re-consider this logic, feels hacky and also not the most efficient.
  bool shouldBeVisible(List<Purchasable> purchasables) {
    if (dependencies.isEmpty) {
      return true;
    }

    return purchasables
        .where((element) => dependencies.contains(element.runtimeType))
        .every((element) => element.purchasedAnyAmount);
  }

  void reset() {
    _purchaseCount = 0;
  }
}
