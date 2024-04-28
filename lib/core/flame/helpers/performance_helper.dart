import 'package:defend_your_flame/constants/performance_constants.dart';

class PerformanceHelper {
  static int toParticleAmount(int amount) {
    return (amount * PerformanceConstants.particleAmount).toInt();
  }
}
