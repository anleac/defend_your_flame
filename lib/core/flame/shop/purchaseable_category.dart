enum PurchaseableCategory {
  walls,
  npcs,
  defenses,
  spells,
}

extension PurchaseableCategoryExtension on PurchaseableCategory {
  String get name {
    switch (this) {
      case PurchaseableCategory.walls:
        return 'Walls';
      case PurchaseableCategory.npcs:
        return 'NPCs';
      case PurchaseableCategory.defenses:
        return 'Defenses';
      case PurchaseableCategory.spells:
        return 'Spells';
    }
  }
}
