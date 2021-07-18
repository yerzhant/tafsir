import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/domain/repo/suwar_repo.dart';
import 'package:tafsir/text/domain/repo/text_repo.dart';

part 'offline_event.dart';
part 'offline_state.dart';
part 'offline_bloc.freezed.dart';

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  final TafsirDB db;
  final SuwarRepo suwarRepo;
  final TextRepo textRepo;

  OfflineBloc(this.db, this.suwarRepo, this.textRepo) : super(const _State(0));

  @override
  Stream<OfflineState> mapEventToState(OfflineEvent event) => event.when(
        download: _download,
      );

  Stream<OfflineState> _download() async* {
    yield const _State(0);

    await db.deleteTafsir();
    Modular.get<SuwarBloc>().add(const SuwarEvent.load());

    // final suwarResult = await suwarRepo.getAll();

    // yield* suwarResult.fold(
    //   (l) async* {
    //     yield _Error(l);
    //   },
    //   (suwar) async* {
    //     for (var i = 0; i < suwar.length; i++) {
    //       await textRepo.getItems(suwar[i]);

    //       final progress = i / (suwar.length - 1) * 100;
    //       yield _State(progress);
    //     }
    //   },
    // );

    // Modular.to.pop();
  }
}
