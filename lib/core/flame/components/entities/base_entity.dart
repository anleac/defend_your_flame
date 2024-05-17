import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

abstract class BaseEntity extends SpriteAnimationGroupComponent<EntityState>
    with ParentIsA<EntityManager>, HasWorldReference<MainWorld>, HasGameReference<MainGame>, HasVisibility {
  late Vector2 _startingPosition;

  Vector2 get startPosition => _startingPosition;

  @override
  void onMount() {
    super.onMount();
    _startingPosition = position.clone();
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isVisible && super.containsLocalPoint(point);
  }
}
