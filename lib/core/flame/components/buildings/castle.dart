import 'dart:async';

import 'package:defend_your_flame/core/flame/components/effects/flame.dart';
import 'package:defend_your_flame/core/flame/managers/sprite_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class Castle extends SpriteComponent with ParentIsA<MainWorld> {
  late final Flame _topFlame = Flame()..position = Vector2(0, -20);

  Castle()
      : super(
            size: Vector2(871, 526),
            sprite: SpriteManager.getSprite('castle'),
            scale: Vector2.all(0.65),
            anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() {
    add(_topFlame);
    return super.onLoad();
  }
}
