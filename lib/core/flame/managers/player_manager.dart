import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class PlayerManager extends PositionComponent with ParentIsA<MainWorld> {
  late final PlayerBase _playerBase = PlayerBase()
    ..position = Vector2(parent.worldWidth - PlayerBase.baseWidth, parent.worldHeight - PlayerBase.baseHeight);

  int _gold = 0;

  int get totalGold => _gold;
  PlayerBase get playerBase => _playerBase;

  @override
  Future<void> onLoad() async {
    add(_playerBase);
    return super.onLoad();
  }

  // TODO: Update this properly towards beta to take into account load states etc.
  void reset() {
    _gold = 0;
    _playerBase.reset();
  }

  void mutateGold(int gold) => _gold += gold;
}
