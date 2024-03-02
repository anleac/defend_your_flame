import 'dart:io';

import 'package:defend_your_flame/constants/constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

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

  static Vector2? _getMaxRenderSize() {
    // For performance reasons, we only want to limit the size on web.
    if (isWeb) {
      return Vector2(Constants.desiredWidth, Constants.desiredHeight);
    }

    return null;
  }
}
