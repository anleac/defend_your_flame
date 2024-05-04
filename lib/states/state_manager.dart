import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/game_provider.dart';
import 'package:defend_your_flame/helpers/platform_helper.dart';
import 'package:defend_your_flame/widgets/background.dart';
import 'package:defend_your_flame/widgets/platform_wrappers/web_wrapper.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class StateManager extends StatefulWidget {
  const StateManager({super.key});

  @override
  State<StateManager> createState() => _StateManagerState();
}

class _StateManagerState extends State<StateManager> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppStringsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppStrings.supportedLocales.map((e) => Locale(e)),
        initialRoute: '/',
        routes: {
          '/': (context) {
            var game = GameProvider.of(context).game;
            game.setExternalDependencies(context);

            Widget gameWidget = GameWidget(
              game: game,
              backgroundBuilder: (context) => const Background(),
            );

            if (PlatformHelper.isWeb) {
              gameWidget = WebWrapper(child: gameWidget);
            }

            return Scaffold(body: PopScope(canPop: false, child: gameWidget));
          }
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
