import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/components/default_hud_background.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/save_load/game_save_selector.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/save_load/game_save_description.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/save_load/load_game_title_text.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class LoadGameHud extends BasicHud with ParentIsA<GameSelectionHud>, HasGameReference<MainGame> {
  static const double padding = 30;

  late final DefaultHudBackground _background = DefaultHudBackground(world: world, sizeFactor: 0.9);

  late final LoadGameTitleText _loadGameTitleText = LoadGameTitleText()
    ..position = _background.headerRect.center.toVector2()
    ..anchor = Anchor.center;

  late final GameSaveDescription _gameSaveDescription = GameSaveDescription()
    ..position = _background.bodyRect.center.toVector2()
    ..size = Vector2(_background.bodyRect.size.width / 2 - padding, _background.bodyRect.size.height - padding * 2)
    ..anchor = Anchor.centerLeft;

  late final GoBackButton _backButton = GoBackButton(backFunction: () => onBackButtonPressed())
    ..position = _background.footerRect.center.toVector2()
    ..anchor = Anchor.center;

  @override
  FutureOr<void> onLoad() {
    add(_background);
    add(_loadGameTitleText);
    add(_backButton);

    var selectorHeight =
        ((_background.bodyRect.height - padding * 2) - (padding * (game.gameData.saveKeys.length - 1))) /
            game.gameData.saveKeys.length;
    var rollingPosition = _background.bodyRect.topLeft.toVector2() + Vector2.all(padding);
    for (final saveKey in game.gameData.saveKeys) {
      final saveSelector = GameSaveSelector(saveKey, selectorHeight)
        ..position = rollingPosition
        ..anchor = Anchor.topLeft;

      rollingPosition += Vector2(0, saveSelector.size.y + padding);

      add(saveSelector);
    }

    return super.onLoad();
  }

  void gameSaveSelected(String gameSaveKey) {
    _gameSaveDescription.setSaveKey(gameSaveKey);

    if (!_gameSaveDescription.isMounted) {
      add(_gameSaveDescription);
    }
  }

  void onBackButtonPressed() {
    if (_gameSaveDescription.isMounted) {
      _gameSaveDescription.removeFromParent();
    }

    parent.changeState(GameSelectionHudState.menu);
  }

  @override
  void reset() {
    for (final component in children) {
      if (component is GameSaveSelector) {
        component.refreshState();
      }
    }

    super.reset();
  }
}
