abstract class Purchasable {
  final String name;
  final String description;
  final int cost;

  final bool comingSoon;

  bool _purchased = false;
  bool get purchased => _purchased;

  Purchasable(
      {required this.name,
      required this.description,
      required this.cost,
      this.comingSoon = false,
      bool purchased = false}) {
    _purchased = purchased;
  }

  void setPurchased() {
    _purchased = true;
  }
}
