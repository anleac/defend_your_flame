import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:defend_your_flame/core/storage/basic_obsfucation.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData extends Model with BasicObsfucation {
  static GameData of(BuildContext context) => ScopedModel.of<GameData>(context);

  // Two custom saves, and one auto save
  static const int saveStatesAllowed = 0;
  static const String gameSavePrefix = 'golden_eye_n64_';
  static const String gameSaveAutoKey = '${gameSavePrefix}auto';
  static const int autoSaveIndex = 0;

  late final List<String> saveKeys =
      [gameSaveAutoKey] + List.generate(saveStatesAllowed, (index) => '$gameSavePrefix$index');

  late final Map<String, String?> _saves;

  final SharedPreferences _preferences;

  bool get hasAutoSave => _saves[gameSaveAutoKey] != null;
  GameSave get autoSave => GameSave.fromJsonString(_saves[gameSaveAutoKey]!);

  GameData(this._preferences) {
    _initSaves();
  }

  _initSaves() {
    _saves = {for (var key in saveKeys) key: _readValue(key)};

    if (DebugConstants.fakeSaveData) {
      _saves[gameSaveAutoKey] = GameSave(
        version: VersioningConstants.version,
        saveSlot: autoSaveIndex,
        currentRound: 3,
        currentWallHealth: 80,
        currentGold: 300,
        currentFlameMana: 100,
        purchaseOrder: [],
        saveDate: DateTime.now().add(const Duration(days: -3)),
      ).toJsonString();
    }
  }

  String? loadSave(String key) => _saves[key];
  void saveSave(GameSave save, int saveSlot) {
    var saveKey = saveKeys[saveSlot];
    var saveString = save.toJsonString();
    _saves[saveKey] = saveString;

    _setValue(saveKey, saveString);
  }

  void clearAutoSave() {
    _saves[gameSaveAutoKey] = null;
    _removeValue(gameSaveAutoKey);
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

  _removeValue(String key) async {
    await _preferences.remove(key);
  }

  void forceReload() {
    notifyListeners();
  }
}
