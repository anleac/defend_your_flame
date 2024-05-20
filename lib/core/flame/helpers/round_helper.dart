import 'package:defend_your_flame/helpers/misc_helper.dart';

class RoundHelper {
  static (double spawnDuration, double approximateTotalDuration) roundDuration(int currentRound) {
    double spawnDuration = MiscHelper.tapper(currentRound * 8, tapperLess: true).ceil() + 7;
    return (spawnDuration, spawnDuration * 1.5);
  }
}
