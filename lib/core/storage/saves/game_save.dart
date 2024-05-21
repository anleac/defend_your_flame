import 'package:json_annotation/json_annotation.dart';

part 'game_save.g.dart';

// Ensure to run `dart run build_runner build` if you change this file
@JsonSerializable()
class GameSave {
  final int currentRound;
  final int currentWallHealth;
  final int currentGold;
  final int currentFlameMana;

  final DateTime saveDate;

  GameSave({
    required this.currentRound,
    required this.currentWallHealth,
    required this.currentGold,
    required this.currentFlameMana,
    required this.saveDate,
  });

  factory GameSave.fromJson(Map<String, dynamic> json) => _$GameSaveFromJson(json);
  Map<String, dynamic> toJson() => _$GameSaveToJson(this);
}
