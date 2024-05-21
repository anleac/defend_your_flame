import 'dart:async';

import 'package:defend_your_flame/core/flame/components/hud/base_components/basic_hud.dart';

abstract class StatefulHud<T> extends BasicHud {
  late T _initialState;
  late T _state;
  late final Map<T, BasicHud> _huds;

  void init(T initialState, Map<T, BasicHud> huds) {
    _initialState = initialState;
    _state = initialState;
    _huds = huds;
  }

  @override
  FutureOr<void> onLoad() {
    add(_huds[_state]!);
    return super.onLoad();
  }

  @override
  void reset() {
    for (var child in children) {
      if (child is BasicHud) {
        child.reset();
      }
    }

    changeState(_initialState);

    super.reset();
  }

  void changeState(T state) {
    if (_state == state) return;
    _state = state;

    for (var child in children) {
      if (child is BasicHud) {
        child.removeFromParent();
      }
    }

    var hudToShow = _huds[_state]!;
    hudToShow.reset();
    add(hudToShow);
  }
}
