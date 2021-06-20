import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/suwar/domain/repo/suwar_repo.dart';

part 'suwar_event.dart';
part 'suwar_state.dart';
part 'suwar_bloc.freezed.dart';

class SuwarBloc extends Bloc<SuwarEvent, SuwarState> {
  final SuwarRepo repo;
  final SettingsRepo settingsRepo;
  final TafsirDB db;

  SuwarBloc(this.repo, this.settingsRepo, this.db) : super(const _InProgress());

  @override
  Stream<SuwarState> mapEventToState(SuwarEvent event) => event.when(
        load: _load,
        updateActiveSurah: _updateActiveSurah,
      );

  Stream<SuwarState> _load() async* {
    yield const _InProgress();

    Surah? surah;
    final textPosition = await settingsRepo.getSavedTextPosition();
    if (textPosition != null) {
      surah = await db.getSurahByWeight(textPosition.surahWeight);
    }

    final result = await repo.getAll();

    yield result.fold(
      (l) => _Error(l),
      (r) => SuwarState(r, surah),
    );
  }

  Stream<SuwarState> _updateActiveSurah(Surah surah) async* {
    yield state.maybeWhen(
      (suwar, active) => SuwarState(suwar, surah),
      orElse: () => state,
    );
  }
}
