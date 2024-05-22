import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/default_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/save_load/game_save_description.dart';
import 'package:flame/components.dart';

class LoadSavedGameButton extends DefaultButton with ParentIsA<GameSaveDescription> {
  LoadSavedGameButton() : super(underlined: false);

  @override
  FutureOr<void> onLoad() {
    text = game.appStrings.loadGame;
    return super.onLoad();
  }

  @override
  void onPressed() {
    parent.loadGame();
    super.onPressed();
  }
}
