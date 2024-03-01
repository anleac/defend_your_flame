import 'package:defend_your_flame/core/flame/game_provider.dart';
import 'package:defend_your_flame/helpers/platform_helper.dart';
import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:defend_your_flame/states/state_manager.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var preferences = await SharedPreferences.getInstance();
  var gameData = GameData(preferences);

  if (PlatformHelper.isMobile) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  runApp(ScopedModel<GameData>(
      model: gameData,
      child: _buildPlatformDimensionsIfNeeded(
          app: ScopedModel<GameProvider>(model: GameProvider(), child: const StateManager()))));
}

Widget _buildPlatformDimensionsIfNeeded({
  required Widget app,
}) {
  var maxWidth = PlatformHelper.maxRenderWidth;
  var maxHeight = PlatformHelper.maxRenderHeight;

  if (maxWidth == null || maxHeight == null) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: app,
      ),
    ),
  );
}
