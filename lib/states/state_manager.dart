import 'package:defend_your_flame/constants/platform_constants.dart';
import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/game_provider.dart';
import 'package:defend_your_flame/helpers/platform_helper.dart';
import 'package:defend_your_flame/widgets/background.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
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
        routes: {
          '/': (context) {
            var game = GameProvider.of(context).game;
            game.setExternalDependencies(context);
            return Scaffold(
                body: Center(
                    child: PopScope(
                        canPop: false,
                        child: _buildPlatformDimensionsIfNeeded(
                          game: GameWidget(
                            game: game,
                            backgroundBuilder: (context) => const Background(),
                          ),
                        ))));
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

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ClipRect(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: game,
        ),
      ),
      if (PlatformHelper.isWeb && !Uri.base.toString().contains(PlatformConstants.webHtmlUrl))
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("If you're noticing poor performance, try this link: "),
            TextButton(
              onPressed: () => launchUrl(Uri.parse(PlatformConstants.webHtmlUrl)),
              child: const Text('HTML version'),
            ),
          ],
        ),
    ]);
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
