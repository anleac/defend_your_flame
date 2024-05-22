import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_back_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/buttons/go_forward_button.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_hud.dart';
import 'package:defend_your_flame/core/flame/components/hud/game_selection_internal/game_selection_hud_state.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/save_load/game_save_description.dart';
import 'package:defend_your_flame/core/flame/components/hud/text/save_load/save_overwrite_text.dart';
import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:flame/components.dart';

class SaveOverwriteHud extends BasicHud with ParentIsA<GameSelectionHud> {
  static const double confirmationButtonHorizontalGap = 30;

  late final SaveOverwriteText _saveOverwriteText = SaveOverwriteText()
    ..position = Vector2(world.worldWidth / 2, world.worldHeight / 3);

  late final GameSaveDescription _gameSaveDescription = GameSaveDescription()
    ..position = _saveOverwriteText.position + Vector2(0, 120)
    ..anchor = Anchor.center
    ..size = Vector2(350, 140);

  late final GoBackButton _goBackButton = GoBackButton(backFunction: () {
    parent.changeState(GameSelectionHudState.menu);
  })
    ..position = _gameSaveDescription.position + Vector2(-confirmationButtonHorizontalGap * 2, 115)
    ..anchor = Anchor.centerRight;

  late final GoForwardButton _goForwardButton = GoForwardButton(forwardFunction: () {
    parent.forceStartNewGame();
  })
    ..position = _gameSaveDescription.position + Vector2(confirmationButtonHorizontalGap, 115)
    ..anchor = Anchor.centerLeft;

  @override
  Future<void> onLoad() async {
    _gameSaveDescription.setSaveKey(GameData.gameSaveAutoKey);

    add(_saveOverwriteText);
    add(_gameSaveDescription);
    add(_goBackButton);
    add(_goForwardButton);

    return super.onLoad();
  }

  @override
  void onMount() {
    _gameSaveDescription.loadGameSave();
    super.onMount();
  }
}
