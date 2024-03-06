import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/blue_flame.dart';
import 'package:defend_your_flame/core/flame/components/effects/purple_flame.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Castle extends SpriteComponent with ParentIsA<MainWorld> {
  late final PurpleFlame _topPurpleFlame = PurpleFlame()
    ..position = Vector2(373, 46)
    ..scale = Vector2.all(2);

  late final BlueFlame _topBlueFlame = BlueFlame()
    ..position = Vector2(200, -23)
    ..scale = Vector2.all(2.6);

  Castle()
      : super(
            size: Vector2(871, 526),
            sprite: SpriteManager.getSprite('castle'),
            scale: Vector2.all(0.65),
            anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() {
    add(_topPurpleFlame);
    add(_topBlueFlame);
    return super.onLoad();
  }
}
