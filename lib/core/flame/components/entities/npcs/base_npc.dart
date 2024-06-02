import 'package:defend_your_flame/core/flame/mixins/has_value_timer_action.dart';
import 'package:defend_your_flame/core/flame/mixins/has_world_state_manager.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';
import 'package:flame/components.dart';

abstract class BaseNpc extends SpriteAnimationComponent
    with HasWorldReference<MainWorld>, HasWorldStateManager, HasValueTimerAction {
  late final Iterable<SpriteAnimation> _animations = loadAnimations();

  BaseNpc({super.size}) {
    scale = Vector2.all(1.45);
  }

  Iterable<SpriteAnimation> loadAnimations();

  @override
  Future<void> onLoad() async {
    _startAnimation(_animations.first);
  }

  _startAnimation(SpriteAnimation nextAnimation) async {
    if (animation == nextAnimation) {
      animationTicker?.reset();
      return;
    }

    nextAnimation.loop = false;
    animation = nextAnimation;
    animationTicker?.onComplete = () {
      _startAnimation(MiscHelper.randomElement(_animations));
    };
  }
}
