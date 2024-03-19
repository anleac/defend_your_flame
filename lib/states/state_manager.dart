import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/game_provider.dart';
import 'package:defend_your_flame/core/flame/managers/text_manager.dart';
import 'package:defend_your_flame/helpers/platform_helper.dart';
import 'package:defend_your_flame/widgets/background.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
/*
  Current game states - TBD
*/

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
        theme: ThemeData(fontFamily: TextManager.defaultFontFamily),
        routes: {
          '/': (context) {
            var game = GameProvider.of(context).game;
            game.setExternalDependencies(context);
            return Scaffold(
                body: Center(
                    child: PopScope(
                        canPop: false,
                        child: _buildPlatformDimensionsIfNeeded(
                            game: Padding(
                          padding: EdgeInsets.all(PlatformHelper.borderPadding),
                          child: GameWidget(
                            game: game,
                            backgroundBuilder: (context) => const Background(),
                          ),
                        )))));
          }
        });
  }

  Widget _buildPlatformDimensionsIfNeeded({
    required Widget game,
  }) {
    var maxWidth = PlatformHelper.maxRenderWidth;
    var maxHeight = PlatformHelper.maxRenderHeight;

    if (maxWidth == null || maxHeight == null) {
      return game;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: ClipRect(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            child: game,
          ),
        )),
        if (PlatformHelper.isWeb) PlatformHelper.webRedirectFooter()
      ],
    );
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
