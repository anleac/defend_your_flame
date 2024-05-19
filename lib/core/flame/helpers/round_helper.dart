import 'package:defend_your_flame/helpers/misc_helper.dart';

class RoundHelper {
  static double approximateSecondsOfRound(int currentRound) {
    return MiscHelper.tapper(currentRound * 10, tapperLess: true).ceil() + 7;
  }
}
