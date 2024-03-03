import 'package:defend_your_flame/constants/constants.dart';
import 'package:flame/components.dart';

/// A class that fakes the timestep.
/// It is used to simulate a lower framerate for debugging purposes to ensure the game runs smoothly at lower framerates.
/// We can add this to the game loop so it will consume the current game tick, and we can correctly calculate the next fake tick.
class TimestepFaker extends Component {
  static const componentKey = 'TimestepFaker';

  final bool useFakeTimestep;
  final int fakeFps;
  late final double fakeTimestep;

  double _fpsFrameCounter = 0;
  int _framesToExecute = 0;

  TimestepFaker({required this.useFakeTimestep, required this.fakeFps}) : super(key: ComponentKey.named(componentKey)) {
    fakeTimestep = 1 / fakeFps;
  }

  @override
  void update(double dt) {
    _fpsFrameCounter += dt;

    _framesToExecute = (_fpsFrameCounter / fakeTimestep).floor();
    _fpsFrameCounter -= _framesToExecute * fakeTimestep;
  }

  void updateWithFakeTimestep(double dt, void Function(double dt) update) {
    if (useFakeTimestep && Constants.debugBuild) {
      for (var i = 0; i < _framesToExecute; i++) {
        update(fakeTimestep);
      }
    } else {
      update(dt);
    }
  }
}
