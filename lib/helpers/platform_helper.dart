import 'dart:io';

import 'package:defend_your_flame/constants/platform_constants.dart';
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
}
