import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';

class AppStringData {
  static final Map<String, Map<String, String>> values = {
    'en': {
      'roundText': 'Round ${AppStrings.placeholderText}',
      'startGame': 'Start Game',
      'loadGame': 'Load Game',
      'saveGame': 'Save Game',
      'enterShop': "Enter Shop",
      'credits': 'Credits',
      'restartGame': 'Restart Game',
      'gameOver': 'Game Over',
      'back': 'Back',
      'shop': 'Shop',
      'description': 'Description',
      'itemCostLabel': 'Cost:',
      'itemTitleLabel': 'Item:',
      'buy': 'Buy',
      'cantAfford': 'Not enough gold',
      'alreadyPurchased': 'Already bought',
      'startRound': 'Start Next Round',
      'healthIndicatorAmount': '${AppStrings.placeholderText}/${AppStrings.placeholderText}',

      // Purchasables
      'woodenWallName': 'Wooden Wall',
      'woodenWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max health",
        "+${AppStrings.placeholderText} defence",
      ], quote: "Nothing like 10 feet of wall to keep\nyou safe from the world."),

      'stoneWallName': 'Stone Wall',
      'stoneWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max health",
        "+${AppStrings.placeholderText} defence",
      ], quote: "I found a wall of wood, and left it a wall\nof stone."),
    },
  };
}
