import 'package:defend_your_flame/core/storage/basic_obsfucation.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData extends Model with BasicObsfucation {
  static GameData of(BuildContext context) => ScopedModel.of<GameData>(context);

  // Two custom saves, and one auto save
  static const int saveStatesAllowed = 2;
  static const String gameSavePrefix = 'golden_eye_n64_';
  static const String gameSaveAuto = '${gameSavePrefix}auto';

  late final List<String> saveKeys =
      List.generate(saveStatesAllowed, (index) => '$gameSavePrefix$index') + [gameSaveAuto];

  late final Map<String, String?> _saves;

  final SharedPreferences _preferences;

  GameData(this._preferences) {
    _initSaves();
  }

  _initSaves() {
    _saves = {for (var key in saveKeys) key: _readValue(key)};
  }

  String loadSave(String key) => _saves[key]!;
  void saveSave(GameSave save, String key) {
    var saveString = save.toJson().toString();
    _saves[key] = saveString;
    _setValue(key, saveString);
  }

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
