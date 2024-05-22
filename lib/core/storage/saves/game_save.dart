import 'dart:convert';

import 'package:defend_your_flame/constants/versioning_constants.dart';
import 'package:defend_your_flame/core/flame/shop/purchaseable_type.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_save.g.dart';

// Ensure to run `dart run build_runner build` if you change this file
@JsonSerializable()
class GameSave {
  final String version;
  final int saveSlot;

  final int currentRound;
  final int currentWallHealth;
  final int currentGold;
  final int currentFlameMana;

  final DateTime saveDate;
  final List<PurchaseableType> purchaseOrder;

  bool get isAutoSave => saveSlot == GameData.autoSaveIndex;

  GameSave({
    required this.version,
    required this.saveSlot,
    required this.currentRound,
    required this.currentWallHealth,
    required this.currentGold,
    required this.currentFlameMana,
    required this.saveDate,
    required this.purchaseOrder,
  });

  factory GameSave.fromData(MainWorld world, {int saveSlot = GameData.autoSaveIndex}) {
    return GameSave(
      version: VersioningConstants.version,
      saveSlot: saveSlot,
      currentRound: world.roundManager.currentRound + 1, // Increment by 1 as we want to save the next round
      currentWallHealth: world.playerBase.wall.health,
      currentGold: world.playerBase.totalGold,
      currentFlameMana: world.playerBase.flameMana,
      saveDate: DateTime.now(),
      purchaseOrder: world.shopManager.purchaseOrder,
    );
  }

  factory GameSave.fromJson(Map<String, dynamic> json) => _$GameSaveFromJson(json);
  factory GameSave.fromJsonString(String jsonString) => GameSave.fromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$GameSaveToJson(this);
  String toJsonString() => jsonEncode(this);
}
