// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_save.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSave _$GameSaveFromJson(Map<String, dynamic> json) => GameSave(
      currentRound: (json['currentRound'] as num).toInt(),
      currentWallHealth: (json['currentWallHealth'] as num).toInt(),
      currentGold: (json['currentGold'] as num).toInt(),
      currentFlameMana: (json['currentFlameMana'] as num).toInt(),
      saveDate: DateTime.parse(json['saveDate'] as String),
    );

Map<String, dynamic> _$GameSaveToJson(GameSave instance) => <String, dynamic>{
      'currentRound': instance.currentRound,
      'currentWallHealth': instance.currentWallHealth,
      'currentGold': instance.currentGold,
      'currentFlameMana': instance.currentFlameMana,
      'saveDate': instance.saveDate.toIso8601String(),
    };
