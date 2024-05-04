import 'package:defend_your_flame/constants/constants.dart';
import 'package:defend_your_flame/constants/platform_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebWrapper extends StatefulWidget {
  static const double webMaxDimensionFactor = 1.2;
  static const double maxWebWidth = Constants.desiredWidth * webMaxDimensionFactor;
  static const double maxWebHeight = Constants.desiredHeight * webMaxDimensionFactor;

  static const double borderPadding = 25;

  final Widget child;

  const WebWrapper({super.key, required this.child});

  @override
  WebWrapperState createState() => WebWrapperState();
}

class WebWrapperState extends State<WebWrapper> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: WebWrapper.maxWebWidth,
                maxHeight: WebWrapper.maxWebHeight,
              ),
              child: Container(
                padding: const EdgeInsets.all(WebWrapper.borderPadding),
                child: AspectRatio(
                  aspectRatio: Constants.desiredAspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
          _webRedirectFooter(),
        ],
      ),
    );
  }

  Widget _webRedirectFooter() {
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