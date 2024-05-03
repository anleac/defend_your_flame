import 'package:defend_your_flame/constants/translations/app_string_data.dart';
import 'package:defend_your_flame/helpers/translation_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) => AppStrings.supportedLocales.contains(locale.languageCode);

  @override
  Future<AppStrings> load(Locale locale) {
    return SynchronousFuture<AppStrings>(AppStrings(locale));
  }

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}

class AppStrings {
  static const supportedLocales = ['en'];
  static const defaultLocal = 'en';
  static const placeholderText = '{0}';

  static Map<String, String>? _cachedMap;

  AppStrings(this.loc);

  final Locale loc;

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  Map<String, String> get localMap {
    if (_cachedMap == null) {
      var lc = AppStringData.values.containsKey(loc.languageCode) ? loc.languageCode : defaultLocal;
      _cachedMap = AppStringData.values[lc];
    }

    return _cachedMap!;
  }

  String getValue(String key) {
    var v = localMap[key];
    if (loc.languageCode != 'en' && (v == '' || v == null)) {
      return AppStringData.values['en']![key]!;
    }

    return v!;
  }

  // Below this are declarations of all the strings used in the app, above is setup.
  String roundText(int round) => TranslationHelper.insertNumber(getValue('roundText'), round);
  String get restartGame => getValue('restartGame');
  String get gameOver => getValue('gameOver');
  String get back => getValue('back');
  String get healthIndicatorText => getValue('healthIndicatorAmount');

  // Main menu
  String get startGame => getValue('startGame');
  String get loadGame => getValue('loadGame');
  String get howToPlay => getValue('howToPlay');
  String get credits => getValue('credits');

  // Between rounds
  String get startRound => getValue('startRound');
  String get saveGame => getValue('saveGame');
  String get enterShop => getValue('enterShop');

  // Shop
  String get shop => getValue('shop');
  String get description => getValue('description');
  String get itemTitleLabel => getValue('itemTitleLabel');
  String get itemCostLabel => getValue('itemCostLabel');
  String get buy => getValue('buy');
  String get cantAfford => getValue('cantAfford');
  String get alreadyPurchased => getValue('alreadyPurchased');
  String get noItemSelected => getValue('noItemSelected');

  // Purchasables
  String get woodenWallName => getValue('woodenWallName');
  String get woodenWallDescription => getValue('woodenWallDescription');

  String get stoneWallName => getValue('stoneWallName');
  String get stoneWallDescription => getValue('stoneWallDescription');
}
