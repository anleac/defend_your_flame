import 'package:defend_your_flame/constants/translations/app_string_helper.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';

class AppStringData {
  static final Map<String, Map<String, String>> values = {
    'en': {
      'roundText': 'Round ${AppStrings.placeholderText}',
      'endOfRoundText': 'End Of Round ${AppStrings.placeholderText}',
      'saveGame': 'Save Game',
      'restartGame': 'Restart Game',
      'gameOver': 'Game Over',
      'gameOverRoundText': 'You made it to round ${AppStrings.placeholderText}',
      'back': 'Back',
      'startRound': 'Start Next Round',
      'healthIndicatorAmount': '${AppStrings.placeholderText}/${AppStrings.placeholderText}',

      // Main menu
      'startGame': 'Start Game',
      'loadGame': 'Load Game',
      'howToPlay': 'How To Play',
      'credits': 'Credits',

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
      'potentialPurchaseCount': '${AppStrings.placeholderText}/${AppStrings.placeholderText} purchased',

      // Tips
      'gameTip0': 'Injure flying enemies by throwing others into them or by tapping',
      'gameTip1': 'Dimensia is a hidden gem of a game',
      'gameTip2': 'Be careful of throwing enemies into your wall to avoid damaging it',
      'gameTip3': 'Flying enemies can not be dragged, but they can be tapped and collided with',
      'gameTip4': 'Ensure to use your gold to upgrade your defenses between rounds',

      // Purchasables
      'woodenWallName': 'Wooden Wall',
      'woodenWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max wall health",
        "+${AppStrings.placeholderText} wall defence",
      ]),
      'woodenWallQuote': '"The wall just got 10 feet higher."',

      'stoneWallName': 'Stone Wall',
      'stoneWallDescription': AppStringHelper.purchasableDescription(attributes: [
        "+${AppStrings.placeholderText} max wall health",
        "+${AppStrings.placeholderText} wall defence",
      ]),
      'stoneWallQuote': '"I found a wall of wood, and left it a wall\nof stone."',

      'attackTotemName': 'Attack Totem',
      'attackTotemDescription': AppStringHelper.purchasableDescription(attributes: [
        "Automatically attacks enemies",
        "Damage scales with the strength of\nyour flame",
      ]),
      'attackTotemQuote': '"The best defense is a good offense."',
    },
  };
}
