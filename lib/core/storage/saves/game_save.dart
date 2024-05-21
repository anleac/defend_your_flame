import 'dart:convert';

import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_save.g.dart';

// Ensure to run `dart run build_runner build` if you change this file
@JsonSerializable()
class GameSave {
  final int saveSlot;

  final int currentRound;
  final int currentWallHealth;
  final int currentGold;
  final int currentFlameMana;

  final DateTime saveDate;

  bool get isAutoSave => saveSlot == GameData.autoSaveIndex;

  GameSave({
    required this.saveSlot,
    required this.currentRound,
    required this.currentWallHealth,
    required this.currentGold,
    required this.currentFlameMana,
    required this.saveDate,
  });

  factory GameSave.fromJson(Map<String, dynamic> json) => _$GameSaveFromJson(json);
  Map<String, dynamic> toJson() => _$GameSaveToJson(this);

  String toJsonString() => jsonEncode(this);
}
