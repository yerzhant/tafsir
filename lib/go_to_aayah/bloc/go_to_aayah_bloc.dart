import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/go_to_aayah/ui/go_to_aayah_slider.dart';

part 'go_to_aayah_bloc.freezed.dart';
part 'go_to_aayah_event.dart';
part 'go_to_aayah_state.dart';

class GoToAayahBloc extends Bloc<GoToAayahEvent, GoToAayahState> {
  late int aayaatCount;

  late double _lastPositionY;
  late int _lastNumber;

  GoToAayahBloc() : super(const _Inactive(1));

  @override
  Stream<GoToAayahState> mapEventToState(GoToAayahEvent event) => event.when(
        slidedTo: _slidedTo,
        ended: _ended,
      );

  Stream<GoToAayahState> _slidedTo(
    Offset position,
    BuildContext context,
  ) async* {
    if (position.dx > goToAayahSliderWidth) {
      yield _SemiActive(_lastPositionY, _lastNumber);
    } else {
      _lastNumber = _calcNumber(position.dy, context);
      _lastPositionY = position.dy;
      yield _Active(position.dy, _lastNumber);
    }
  }

  Stream<GoToAayahState> _ended() async* {
    final number = state.maybeWhen(
      active: (_, number) => number,
      orElse: () => null,
    );
    if (number != null) yield _GoTo(number);

    yield _Inactive(number ?? _lastNumber);
  }

  int _calcNumber(double position, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final number = (position / height * aayaatCount).round();
    if (number < 1) return 1;
    if (number > aayaatCount) return aayaatCount;
    return number;
  }
}
