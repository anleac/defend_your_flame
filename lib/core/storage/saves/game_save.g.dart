// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_save.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSave _$GameSaveFromJson(Map<String, dynamic> json) => GameSave(
      version: json['version'] as String,
      saveSlot: (json['saveSlot'] as num).toInt(),
      currentRound: (json['currentRound'] as num).toInt(),
      currentWallHealth: (json['currentWallHealth'] as num).toInt(),
      currentGold: (json['currentGold'] as num).toInt(),
      currentFlameMana: (json['currentFlameMana'] as num).toInt(),
      saveDate: DateTime.parse(json['saveDate'] as String),
      purchaseOrder: (json['purchaseOrder'] as List<dynamic>)
          .map((e) => $enumDecode(_$PurchaseableTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$GameSaveToJson(GameSave instance) => <String, dynamic>{
      'version': instance.version,
      'saveSlot': instance.saveSlot,
      'currentRound': instance.currentRound,
      'currentWallHealth': instance.currentWallHealth,
      'currentGold': instance.currentGold,
      'currentFlameMana': instance.currentFlameMana,
      'saveDate': instance.saveDate.toIso8601String(),
      'purchaseOrder': instance.purchaseOrder
          .map((e) => _$PurchaseableTypeEnumMap[e]!)
          .toList(),
    };

const _$PurchaseableTypeEnumMap = {
  PurchaseableType.woodenWall: 'woodenWall',
  PurchaseableType.stoneWall: 'stoneWall',
  PurchaseableType.attackTotem: 'attackTotem',
  PurchaseableType.blacksmith: 'blacksmith',
};
