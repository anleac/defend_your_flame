import 'package:defend_your_flame/constants/parallax_constants.dart';
import 'package:defend_your_flame/core/flame/components/masonry/flames/purple_flame.dart';
import 'package:defend_your_flame/core/flame/components/masonry/misc/rock_circle.dart';
import 'package:defend_your_flame/core/flame/components/masonry/player_base.dart';
import 'package:flame/components.dart';

class FirePit extends PositionComponent with ParentIsA<PlayerBase> {
  late final RockCircle _rockFirePit = RockCircle()
    ..position = Vector2(0, 0)
    ..anchor = Anchor.center;

  late final PurpleFlame _firePitFlame = PurpleFlame()
    ..position = Vector2(ParallaxConstants.horizontalDisplacementFactor * _rockFirePit.size.y / 2, 2)
    ..scale = Vector2(1.2, 2.5)
    ..anchor = Anchor.bottomCenter;

  @override
  Future<void> onLoad() async {
    add(_rockFirePit);
    add(_firePitFlame);
    return super.onLoad();
  }
}
