import 'package:defend_your_flame/core/storage/basic_obsfucation.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData extends Model with BasicObsfucation {
  static GameData of(BuildContext context) => ScopedModel.of<GameData>(context);

  // Two custom saves, and one auto save
  static const int saveStatesAllowed = 2;

  final SharedPreferences _preferences;

  GameData(this._preferences);

  String? _readValue(String key, {bool obfuscate = true, String? defaultValue}) {
    var val = _preferences.getString(key);

    if (val == null) {
      return defaultValue;
    }

    if (obfuscate) {
      val = deobsfucate(val);
    }

    return val;
  }

  _setValue(String key, String val, {bool obfuscate = true}) async {
    if (obfuscate) {
      val = obsfucate(val);
    }

    await _preferences.setString(key, val);
  }

  void forceReload() {
    notifyListeners();
  }
}
