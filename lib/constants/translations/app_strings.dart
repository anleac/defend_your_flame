import 'package:defend_your_flame/constants/translations/app_string_data.dart';
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
}
