import 'package:defend_your_flame/constants/translations/app_string_constants.dart';
import 'package:defend_your_flame/helpers/misc_helper.dart';

class GameTipManager {
  final List<String> _genericTips = [];
  final Map<int, List<String>> _roundTips = {};

  GameTipManager(List<String> tips) {
    _parseTips(tips);
  }

  void _parseTips(List<String> tips) {
    for (var tip in tips) {
      if (tip.contains(AppStringConstants.roundTipDelimiter)) {
        var parts = tip.split(AppStringConstants.roundTipDelimiter);
        var round = int.parse(parts[0]);
        var tipContent = parts[1];

        if (_roundTips.containsKey(round)) {
          _roundTips[round]!.add(tipContent);
        } else {
          _roundTips[round] = [tipContent];
        }
      } else {
        _genericTips.add(tip);
      }
    }
  }

  String getTipForRound(int currentRound) {
    var nextRound = currentRound + 1;
    if (_roundTips.containsKey(nextRound)) {
      return MiscHelper.randomElement(_roundTips[nextRound]!);
    }

    return MiscHelper.randomElement(_genericTips);
  }
}
