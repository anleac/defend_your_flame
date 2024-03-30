import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class Sky extends PositionComponent with HasGameReference<MainGame>, Snapshot {
  @override
  void render(Canvas canvas) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromARGB(255, 18, 85, 192),
        Color.fromARGB(255, 77, 123, 191),
        Color.fromARGB(255, 139, 180, 218),
        Color.fromARGB(255, 184, 223, 242)
      ],
      stops: [
        0.5,
        0.8,
        0.94,
        1.0,
      ],
    );

    final paint = Paint()..shader = gradient.createShader(game.camera.visibleWorldRect);
    canvas.drawRect(game.camera.visibleWorldRect, paint);
  }
}
