import 'package:defend_your_flame/core/helpers/platform_helper.dart';
import 'package:defend_your_flame/core/storage/game_data.dart';
import 'package:defend_your_flame/states/state_manager.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  var preferences = await SharedPreferences.getInstance();
  var gameData = GameData(preferences);

  if (PlatformHelper.isMobile) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  } else if (PlatformHelper.isDesktop || PlatformHelper.isWeb) {
    // TODO lets revisit later if we want to fix resolution.
  }

  runApp(ScopedModel<GameData>(model: gameData, child: const StateManager()));
}
