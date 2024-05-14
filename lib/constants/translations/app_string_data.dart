import 'package:defend_your_flame/constants/entity_spawn_constants.dart';
import 'package:defend_your_flame/constants/translations/app_string_constants.dart';
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

      // Tips
      '${AppStringConstants.gameTipPrefix}0': 'Injure flying enemies by throwing others into them or by tapping',
      '${AppStringConstants.gameTipPrefix}1': 'Dimensia is a hidden gem of a game',
      '${AppStringConstants.gameTipPrefix}2': 'Be careful of throwing enemies into your wall to avoid damaging it',
      '${AppStringConstants.gameTipPrefix}3':
          'Flying enemies can not be dragged, but they can be tapped and collided with',
      '${AppStringConstants.gameTipPrefix}4': 'Ensure to use your gold to upgrade your defenses between rounds',
      '${AppStringConstants.gameTipPrefix}5': 'Certain enemies are too heavy to pick up, slam other enemies into them!',
      '${AppStringConstants.gameTipPrefix}6': AppStringHelper.gameTipForRound(
          EntitySpawnConstants.bossRounds.entries.first.key,
          'The first boss round is up next, be prepared for a heavy enemy!'),
      '${AppStringConstants.gameTipPrefix}7': AppStringHelper.gameTipForRound(
          EntitySpawnConstants.minimumRoundForFastGroundEnemies, 'Some enemies run faster than others, be vigilant'),
      '${AppStringConstants.gameTipPrefix}8': AppStringHelper.gameTipForRound(
          EntitySpawnConstants.minimumRoundForRockGolems,
          'Rock Golems are making their way towards you, they are immune to magical attacks'),

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
