import 'dart:async';
import 'dart:convert';

import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/components/hud/backgrounds/bordered_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/default_text.dart';
import 'package:defend_your_flame/core/flame/components/hud/save_load/load_game_hud.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/mixins/has_mouse_hover.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/rendering.dart';

class GameSaveSelector extends PositionComponent
    with HoverCallbacks, TapCallbacks, HasGameReference<MainGame>, HasMouseHover, ParentIsA<LoadGameHud> {
  static const double rectangleWidth = 280;

  late final BorderedBackground _borderedBackground = BorderedBackground(borderRadius: 8, borderThickness: 2.5)
    ..size = size;

  late final DefaultText _title = DefaultText(text: _titleText(), anchor: Anchor.topCenter)
    ..position = size / 2
    ..anchor = Anchor.center;

  late GameSave? gameSave;
  final String gameSaveKey;
  final double height;

  bool get hasSave => gameSave != null;

  GameSaveSelector(this.gameSaveKey, this.height) {
    size = Vector2(rectangleWidth, height);
  }

  @override
  FutureOr<void> onLoad() {
    refreshState();
    add(_borderedBackground);
    add(_title);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    parent.gameSaveSelected(gameSaveKey);
    super.onTapDown(event);
  }

  void refreshState() {
    var savedData = game.gameData.loadSave(gameSaveKey);
    if (savedData != null) {
      gameSave = GameSave.fromJson(jsonDecode(savedData));
    } else {
      gameSave = null;
    }

    changeHoverStatus(canHover: hasSave);

    decorator.removeLast();
    if (!hasSave) {
      // TODO maybe we can migrate all disabled buttons to use this instead.
      decorator.addLast(PaintDecorator.tint(ThemingConstants.disabledTint));
    }
  }

  String _titleText() {
    if (gameSave == null) {
      return 'No save present';
    } else {
      var prefix = gameSave!.isAutoSave ? 'Auto save: ' : "${gameSave!.saveSlot}: ";
      return "${prefix}Round ${gameSave!.currentRound}";
    }
  }
}
