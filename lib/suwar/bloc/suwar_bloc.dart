import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/suwar/domain/repo/suwar_repo.dart';

part 'suwar_event.dart';
part 'suwar_state.dart';
part 'suwar_bloc.freezed.dart';

class SuwarBloc extends Bloc<SuwarEvent, SuwarState> {
  final SuwarRepo repo;

  SuwarBloc(this.repo) : super(const _InProgress());

  @override
  Stream<SuwarState> mapEventToState(SuwarEvent event) =>
      event.when(load: _mapLoadToState);

  Stream<SuwarState> _mapLoadToState() async* {
    yield const _InProgress();
    final result = await repo.getAll();

    yield result.fold(
      (l) => _Error(l),
      (r) => SuwarState(r),
    );
  }
}
