import 'package:defend_your_flame/core/flame/worlds/main_world.dart';

abstract class Purchasable {
  final Set<Type> dependencies;

  final String name;
  final String description;
  final int cost;
  final bool oneOffPurchase;

  final bool comingSoon;

  bool _purchased = false;
  bool get purchased => _purchased;

  Purchasable(
      {required this.name,
      required this.description,
      required this.cost,
      required this.oneOffPurchase,
      this.dependencies = const {},
      this.comingSoon = false,
      bool purchased = false}) {
    _purchased = purchased;
  }

  void purchase(MainWorld world) {
    _purchased = true;
  }

  // TODO post-beta release: re-consider this logic, feels hacky and also not the most efficient.
  bool shouldBeVisible(List<Purchasable> purchasables) {
    if (dependencies.isEmpty) {
      return true;
    }

    return purchasables
        .where((element) => dependencies.contains(element.runtimeType))
        .every((element) => element.purchased);
  }
}
