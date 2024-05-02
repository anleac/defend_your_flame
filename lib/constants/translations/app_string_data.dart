import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';

class AppStringData {
  static final Map<String, Map<String, String>> values = {
    'en': {
      'roundText': 'Round ${AppStrings.placeholderText}',
      'startGame': 'Start Game',
      'loadGame': 'Load Game',
      'saveGame': 'Save Game',
      'credits': 'Credits',
      'restartGame': 'Restart Game',
      'gameOver': 'Game Over',
      'back': 'Back',
      'startRound': 'Start Next Round',
      'healthIndicatorAmount': '${AppStrings.placeholderText}/${AppStrings.placeholderText}',

      // Shop
      'enterShop': "Enter Shop",
      'shop': 'Shop',
      'description': 'Description',
      'itemCostLabel': 'Cost:',
      'itemTitleLabel': 'Item:',
      'buy': 'Purchase',
      'cantAfford': 'Not enough gold',
      'alreadyPurchased': 'Purchased',
      'noItemSelected': 'No item selected',

      // Purchasables
      'woodenWallName': 'Wooden Wall',
      'woodenWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max wall health",
        "+${AppStrings.placeholderText} wall defence",
      ], quote: "The wall just got 10 feet higher."),

      'stoneWallName': 'Stone Wall',
      'stoneWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max wall health",
        "+${AppStrings.placeholderText} wall defence",
      ], quote: "I found a wall of wood, and left it a wall\nof stone."),
    },
  };
}
