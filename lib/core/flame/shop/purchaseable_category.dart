enum PurchaseableCategory {
  walls,
  defenses,
  flame,
  npcs,
  spells,
}

extension PurchaseableCategoryExtension on PurchaseableCategory {
  // TODO(release) move this to translations file?
  String get name {
    switch (this) {
      case PurchaseableCategory.walls:
        return 'Walls';
      case PurchaseableCategory.npcs:
        return 'NPCs';
      case PurchaseableCategory.defenses:
        return 'Defenses';
      case PurchaseableCategory.flame:
        return 'Flame';
      case PurchaseableCategory.spells:
        return 'Spells';
    }
  }
}
