import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:flame/components.dart';

class PlayerBaseComponent extends PositionComponent with HasWorldReference<MainWorld> {
  PlayerBaseComponent({super.size});
}
