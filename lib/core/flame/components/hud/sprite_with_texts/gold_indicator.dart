import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/components/gold_pile.dart';
import 'package:defend_your_flame/core/flame/components/hud/base_components/sprite_with_text.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class GoldIndicator extends PositionComponent with HasWorldReference<MainWorld> {
  late final GoldPile _goldPile = GoldPile()
    ..scale = Vector2.all(0.24)
    ..anchor = Anchor.centerLeft;

  late final TextComponent _goldText = TextComponent(textRenderer: TextManager.basicHudRenderer)
    ..anchor = Anchor.centerLeft;

  late final SpriteWithText _indicator = SpriteWithText(sprite: _goldPile, text: _goldText);

  @override
  FutureOr<void> onLoad() {
    add(_indicator);
    return super.onLoad();
  }

  @override
  void onMount() {
    _setGoldText();
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _setGoldText();
  }

  _updateSizeOfParent() {
    size = _indicator.size;
  }

  _setGoldText() {
    var gold = world.playerBase.totalGold.toString();
    _indicator.updateLabelText(gold);
    _updateSizeOfParent();
  }
}
