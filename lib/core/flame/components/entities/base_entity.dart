import 'package:defend_your_flame/core/flame/components/entities/enums/entity_state.dart';
import 'package:defend_your_flame/core/flame/components/entities/mixins/has_hitbox_positioning.dart';
import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/managers/entity_manager.dart';
import 'package:defend_your_flame/core/flame/mixins/has_wall_collision_detection.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

abstract class BaseEntity extends SpriteAnimationGroupComponent<EntityState>
    with
        ParentIsA<EntityManager>,
        HasWorldReference<MainWorld>,
        HasGameReference<MainGame>,
        HasVisibility,
        TapCallbacks,
        HasHitboxPositioning,
        GestureHitboxes,
        CollisionCallbacks,
        HasWallCollisionDetection {
  late Vector2 _startingPosition;

  Vector2 get startPosition => _startingPosition;
  Vector2 get trueCenter => absoluteCenterOfMainHitbox();

  @override
  void onMount() {
    super.onMount();
    _startingPosition = position.clone();
  }
}
