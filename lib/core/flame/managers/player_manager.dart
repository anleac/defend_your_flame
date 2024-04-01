import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class PlayerManager extends PositionComponent with ParentIsA<MainWorld> {
  late final PlayerBase _castle = PlayerBase()
    ..position = Vector2(parent.worldWidth - PlayerBase.baseWidth, parent.worldHeight - PlayerBase.baseHeight);

  int _gold = 0;

  int get totalGold => _gold;
  PlayerBase get castle => _castle;

  @override
  Future<void> onLoad() async {
    add(_castle);
    return super.onLoad();
  }

  // TODO: Update this properly towards beta to take into account load states etc.
  void reset() {
    _gold = 0;
    _castle.reset();
  }

  void addGold(int gold) => _gold += gold;
}
