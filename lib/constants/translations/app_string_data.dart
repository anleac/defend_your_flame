import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
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
      'selectGame': 'Start A Game',
      'howToPlay': 'How To Play',
      'credits': 'Credits',

      // Game selection
      'startGame': 'Start Game',
      'fastTrackTo': 'Fast Track To Round ${AppStrings.placeholderText}',
      'loadGame': 'Load Game',

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

      // Tips - if you modify tips make sure the tip amount constant in app_string_constants is correct.
      'gameTip0': 'Injure flying enemies by throwing others into them or by tapping',
      'gameTip1': 'Dimensia is a hidden gem of a game',
      'gameTip2': 'Be careful of throwing enemies into your wall to avoid damaging it',
      'gameTip3': 'Flying enemies can not be dragged, but they can be tapped and collided with',
      'gameTip4': 'Ensure to use your gold to upgrade your defenses between rounds',
      'gameTip5': 'Certain enemies are too heavy to pick up, slam other enemies into them!',
      'gameTip6':
          'The first boss round is at round ${EntitySpawnConstants.bossRounds.entries.first.key}, be prepared for a heavy enemy!',

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
