import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';

part 'active_page_event.dart';
part 'active_page_state.dart';

const _preamble = -1;

class ActivePageBloc extends Bloc<ActivePageEvent, ActivePageState> {
  final TafsirRepository tafsirRepository;

  ActivePageBloc(this.tafsirRepository) : super(ActivePageSuwar(null));

  @override
  Stream<ActivePageState> mapEventToState(ActivePageEvent event) async* {
    if (event is ActivePageSuwarShown) {
      yield ActivePageSuwar(state.surah);
    } else if (event is ActivePageTextShown) {
      var surah = event.surah;

      if (surah == null) {
        surah = await tafsirRepository.getSurahByWeight(_preamble);
      }

      final bookmarks =
          await tafsirRepository.bookmarkRepository.findBySurah(surah);

      yield ActivePageText(surah, bookmarks, event.aayah);
    } else if (event is ActivePageBookmarksShown) {
      final bookmarks = await tafsirRepository.bookmarkRepository.getAll();
      yield ActivePageBookmarks(state.surah, bookmarks);
    }
  }
}
