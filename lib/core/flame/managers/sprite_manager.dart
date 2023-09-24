import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/sprite.dart';

class SpriteManager {
  static bool _inited = false;
  static const String _defaultExt = '.png';

  static Future init() async {
    if (_inited) {
      return;
    }

    _inited = true;
    await Flame.images.loadAllImages();
  }

  static Sprite getSprite(String name) => Sprite(Flame.images.fromCache(_fixName(name)));

  static SpriteSheet getSpriteSheet(String name, {int frames = 1}) {
    var image = Flame.images.fromCache(_fixName(name));
    var srcSize = Vector2(image.width / frames, image.height.toDouble());
    return SpriteSheet(image: image, srcSize: srcSize);
  }

  static SpriteAnimation getAnimation(String name, double stepTime, {int frames = 1}) {
    var image = Flame.images.fromCache(_fixName(name));
    var srcSize = Vector2(image.width / frames, image.height.toDouble());

    return SpriteAnimation.fromFrameData(
        image, SpriteAnimationData.sequenced(amount: frames, stepTime: stepTime, textureSize: srcSize, loop: false));
  }

  static String _fixName(String name) {
    return name.contains('.') ? name : name + _defaultExt;
  }
}
