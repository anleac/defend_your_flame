import 'dart:convert';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_labeled_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/save_load/load_saved_game_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class GameSaveDescription extends PositionComponent
    with HasWorldReference<MainWorld>, HasGameReference<MainGame>, HasAncestor<GameSelectionHud> {
  static const double padding = 20;
  static final Vector2 _itemGap = Vector2(0, 35);

  GameSave? _gameSave;
  String? _gameSaveKey;

  late final BorderedBackground _bodyBackground =
      BorderedBackground(hasFill: true, fillColor: ThemingConstants.borderColour.darken(0.6), opacity: 0.9)
        ..position = Vector2.zero()
        ..anchor = Anchor.topLeft
        ..size = size;

  late final DefaultLabeledText _roundText = DefaultLabeledText(
    label: 'Round:',
    text: '',
  )
    ..position = Vector2(padding, padding)
    ..anchor = Anchor.topLeft;

  late final DefaultLabeledText _goldText = DefaultLabeledText(
    label: 'Gold:',
    text: '',
  )
    ..position = _roundText.position + _itemGap
    ..anchor = Anchor.topLeft;

  late final LoadSavedGameButton _loadButton = LoadSavedGameButton()
    ..position = size - Vector2(padding, padding)
    ..anchor = Anchor.bottomRight;

  @override
  Future<void> onLoad() async {
    add(_bodyBackground);
    add(_roundText);
    add(_goldText);
    add(_loadButton);

    loadGameSave();
    return super.onLoad();
  }

  void loadGameSave() {
    if (_gameSaveKey == null) {
      return;
    }

    var savedData = game.gameData.loadSave(_gameSaveKey!);

    if (savedData != null) {
      _gameSave = GameSave.fromJson(jsonDecode(savedData));
    } else {
      _gameSave = null;
    }

    _refreshUx();
  }

  void _refreshUx() {
    _roundText.updateText(_gameSave?.currentRound.toString() ?? '');
    _goldText.updateText(_gameSave?.currentGold.toString() ?? '');
  }

  void loadGame() {
    removeFromParent();
    ancestor.startGame(round: _gameSave?.currentRound ?? 0, gold: _gameSave?.currentGold ?? 0);
  }

  void setSaveKey(String gameSaveKey) {
    _gameSaveKey = gameSaveKey;

    if (isMounted) {
      loadGameSave();
    }
  }
}
