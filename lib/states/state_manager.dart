import 'dart:math';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/game_provider.dart';
import 'package:defend_your_flame/helpers/platform_helper.dart';
import 'package:defend_your_flame/widgets/background.dart';
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
            return Scaffold(
                body: Background(
                    child: Center(
                        child: PopScope(
                            canPop: false,
                            child: _buildPlatformDimensionBounds(
                                game: Padding(
                              padding: EdgeInsets.all(PlatformHelper.borderPadding),
                              child: GameWidget(
                                game: game,
                                backgroundBuilder: (context) => const Background(),
                              ),
                            ))))));
          }
        });
  }

  Widget _buildPlatformDimensionBounds({
    required Widget game,
  }) {
    var maxWidth = PlatformHelper.maxRenderWidth ?? double.infinity;
    var maxHeight = PlatformHelper.maxRenderHeight ?? double.infinity;

    var currentWidth = MediaQuery.of(context).size.width;

    var theoriticalMaxHeight = currentWidth / Constants.desiredAspectRatio;
    var theoriticalMaxWidth = theoriticalMaxHeight * Constants.desiredAspectRatio;

    var realMaxHeight = min(theoriticalMaxHeight, maxHeight);
    var realMaxWidth = min(theoriticalMaxWidth, maxWidth);

    var boundedGame = Container(
      constraints: BoxConstraints(maxWidth: realMaxWidth, maxHeight: realMaxHeight),
      child: game,
    );

    if (!PlatformHelper.isWeb) {
      return boundedGame;
    }

    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [boundedGame, if (PlatformHelper.isWeb) PlatformHelper.webRedirectFooter()],
    ));
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
