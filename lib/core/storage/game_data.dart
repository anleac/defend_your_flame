import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData extends Model {
  static GameData of(BuildContext context) => ScopedModel.of<GameData>(context);

  // Perhaps we could abstract this to contain various types of storage.
  final SharedPreferences _preferences;

  GameData(this._preferences);

  String? _readValue(String key) {
    var val = _preferences.getString(key);
    if (val == null) {
      return val;
    }

    return val;
  }

  _setValue(String key, String val) async {
    await _preferences.setString(key, val);
  }

  void forceReload() {
    notifyListeners();
  }
}
