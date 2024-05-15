import 'dart:async';

import 'package:defend_your_flame/constants/bounding_constants.dart';
import 'package:defend_your_flame/constants/debug_constants.dart';
import 'package:defend_your_flame/core/flame/components/entities/entity.dart';
import 'package:defend_your_flame/core/flame/components/entities/npcs/blacksmith.dart';
import 'package:defend_your_flame/core/flame/components/masonry/fire_pit.dart';
import 'package:defend_your_flame/core/flame/components/masonry/misc/rock_circle.dart';
import 'package:defend_your_flame/core/flame/components/masonry/totems/attack_totem.dart';
import 'package:defend_your_flame/core/flame/components/masonry/walls/wall.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world_state.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerBase extends PositionComponent with HasWorldReference<MainWorld>, HasVisibility {
  static const double baseWidthWithoutWall = 230;
  static const double baseWidth = baseWidthWithoutWall + Wall.wallAreaWidth;
  static const double baseHeight = 180;

  late final Rect _innerBaseRect = Rect.fromLTWH(position.x + (Wall.wallAreaWidth * 0.7), position.y + Wall.wallYOffset,
      width + BoundingConstants.maxXCoordinateOffScreen, baseHeight - (Wall.wallYOffset * 2));

  late final Wall _wall = Wall()..position = Vector2(0, Wall.wallYOffset);
  late final FirePit _firePit = FirePit()
    ..position = Vector2(Wall.wallAreaWidth + (baseWidthWithoutWall / 2) - 10, baseHeight / 2 - 10);

  int _gold = DebugConstants.testShopLogic ? 5000 : 0;

  int get totalGold => _gold;
  bool get destroyed => _wall.health <= 0;
  Wall get wall => _wall;
  Blacksmith get blacksmith => _blacksmith;

  final List<Component> _additionalComponents = [];

  late final List<AttackTotem> _potentialAttackTotems = [
    AttackTotem()..position = _firePit.position + Vector2(RockCircle.ovalWidth / 2 + 4, -54),
    AttackTotem()..position = _firePit.position + Vector2(RockCircle.ovalWidth / 2 + 7, -10),
    AttackTotem()..position = _firePit.position - Vector2(RockCircle.ovalWidth / 2 + 27, 54),
    AttackTotem()..position = _firePit.position - Vector2(RockCircle.ovalWidth / 2 + 24, 10),
    AttackTotem()..position = _firePit.position + Vector2(RockCircle.ovalWidth / 2 + 22, -74),
    AttackTotem()..position = _firePit.position + Vector2(RockCircle.ovalWidth / 2 + 29, 10),
  ];

  late final Blacksmith _blacksmith = Blacksmith()
    ..position = Vector2(Wall.wallAreaWidth - 20, _firePit.center.y + 5)
    ..anchor = Anchor.bottomLeft;

  PlayerBase({required double worldWidth, required double worldHeight})
      : super(
            size: Vector2(baseWidth, baseHeight), position: Vector2(worldWidth - baseWidth, worldHeight - baseHeight));

  @override
  FutureOr<void> onLoad() {
    add(_wall);
    add(_firePit);

    return super.onLoad();
  }

  void reset() {
    _gold = 0;
    _wall.reset();
    isVisible = true;

    for (var component in _additionalComponents) {
      component.removeFromParent();
    }

    _additionalComponents.clear();
  }

  void mutateGold(int gold, {Vector2? position}) {
    _gold += gold;

    if (position != null) {
      world.effectManager.addGoldText(gold, position);
    }
  }

  void takeDamage(int damage, {Vector2? position}) {
    _wall.takeDamage(damage, position: position);

    if (destroyed) {
      isVisible = false;

      if (world.worldStateManager.playing) {
        world.worldStateManager.changeState(MainWorldState.gameOver);
      }
    }
  }

  void addAttackTotem(int totemIndex) {
    if (totemIndex < _potentialAttackTotems.length) {
      var totem = _potentialAttackTotems[totemIndex];
      _addAdditionalBaseComponent(totem);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (DebugConstants.drawBaseArea) {
      // This is used for debugging
      var relativeRect = _innerBaseRect.translate(-position.x, -position.y);
      canvas.drawRect(relativeRect, DebugConstants.debugPaint);
    }
  }

  bool entityInside(Entity entity) {
    // This is used instead of a collision box as this is more efficient
    if (entity.position.x < world.worldWidth - baseWidth) {
      return false;
    }

    return _innerBaseRect.contains(entity.center.toOffset());
  }

  void purchaseBlacksmith() {
    _addAdditionalBaseComponent(_blacksmith);
  }

  _addAdditionalBaseComponent(Component component) {
    _additionalComponents.add(component);
    add(component);
  }
}
