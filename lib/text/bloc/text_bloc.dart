import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/text/domain/repo/text_repo.dart';

part 'text_event.dart';
part 'text_state.dart';
part 'text_bloc.freezed.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final TextRepo repo;

  TextBloc(this.repo) : super(const _InProgress());

  @override
  Stream<TextState> mapEventToState(TextEvent event) => event.when(load: _load);

  Stream<TextState> _load(Surah surah) async* {
    yield const _InProgress();

    final result = await repo.getItems(surah);

    yield result.fold(
      (l) => _Error(l),
      (r) => TextState(r),
    );
  }
}
