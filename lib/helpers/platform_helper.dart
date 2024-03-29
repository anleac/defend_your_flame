import 'dart:io';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/constants/platform_constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum CurrentPlatform {
  android,
  ios,
  web,
  windows,
  linux,
  macos,
}

class PlatformHelper {
  static CurrentPlatform currentPlatform = _getCurrentPlatform();

  static bool get isMobile => currentPlatform == CurrentPlatform.android || currentPlatform == CurrentPlatform.ios;

  static bool get isAndroid => currentPlatform == CurrentPlatform.android;

  static bool get isDesktop =>
      currentPlatform == CurrentPlatform.windows ||
      currentPlatform == CurrentPlatform.linux ||
      currentPlatform == CurrentPlatform.macos;

  static bool get isWeb => currentPlatform == CurrentPlatform.web;

  static CurrentPlatform _getCurrentPlatform() {
    if (kIsWeb) {
      return CurrentPlatform.web;
    } else if (Platform.isAndroid) {
      return CurrentPlatform.android;
    } else if (Platform.isIOS) {
      return CurrentPlatform.ios;
    } else if (Platform.isWindows) {
      return CurrentPlatform.windows;
    } else if (Platform.isLinux) {
      return CurrentPlatform.linux;
    } else if (Platform.isMacOS) {
      return CurrentPlatform.macos;
    } else {
      throw Exception('Unknown platform');
    }
  }

  static final double? maxRenderWidth = _getMaxRenderSize()?.x;
  static final double? maxRenderHeight = _getMaxRenderSize()?.y;

  static const double _webMaxRenderScale = 1.2;

  static Vector2? _getMaxRenderSize() {
    // To scale this better on web, we want to limit the size of the game to the desired width and height.
    if (isWeb) {
      return Vector2(Constants.desiredWidth, Constants.desiredHeight) * _webMaxRenderScale;
    }

    return null;
  }

  static final double borderPadding = _getBorderPadding();

  static double _getBorderPadding() {
    if (isWeb) {
      return 20;
    }

    return 0;
  }

  static Widget webRedirectFooter() {
    if (!Uri.base.toString().contains(PlatformConstants.webHtmlSuffix)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("If you're noticing poor performance, try this link:"),
          TextButton(
            onPressed: () => launchUrl(Uri.parse(PlatformConstants.webHtmlUrl)),
            child: const Text('HTML version'),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Try the higher graphic version:"),
        TextButton(
          onPressed: () {
            var baseUrl = Uri.base.toString();
            var newUrl = baseUrl.replaceAll(PlatformConstants.webHtmlSuffix, '');
            launchUrl(Uri.parse(newUrl));
          },
          child: const Text('CanvasKit version'),
        ),
      ],
    );
  }
}
