import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';

part 'active_page_event.dart';
part 'active_page_state.dart';

const _images = '$server/media/images/surahs';

class ActivePageBloc extends Bloc<ActivePageEvent, ActivePageState> {
  final TafsirRepository tafsirRepository;

  ActivePageBloc(this.tafsirRepository) : super(ActivePageSuwar(null));

  @override
  Stream<ActivePageState> mapEventToState(ActivePageEvent event) async* {
    if (event is ActivePageSuwarShown) {
      yield ActivePageSuwar(state.surah);
    } else if (event is ActivePageTextScrolledTo) {
      yield ActivePageTextScrollTo(event.surah, event.bookmarks, event.aayah);
    } else if (event is ActivePageTextShown) {
      var surah = event.surah;

      int initialIndex = 0;
      double initialLeadingEdge = 0;

      if (surah == null) {
        final initialTextPosition =
            await tafsirRepository.getInitialTextPosition();
        surah = await tafsirRepository
            .getSurahByWeight(initialTextPosition.surahWeight);
        initialIndex = initialTextPosition.index;
        initialLeadingEdge = initialTextPosition.leadingEdge;
      }

      final bookmarks =
          await tafsirRepository.bookmarkRepository.findBySurah(surah);

      yield ActivePageText(
        surah,
        bookmarks,
        event.aayah,
        initialIndex,
        initialLeadingEdge,
      );
    } else if (event is ActivePageBookmarksShown) {
      final bookmarks = await tafsirRepository.bookmarkRepository.getAll();
      yield ActivePageBookmarks(state.surah, bookmarks);
    } else if (event is ActivePageSuwarDownloaded) {
      yield ActivePageSuwarDownloading(null);

      await tafsirRepository.clearSuwarAndAayaat();

      final suwar = await tafsirRepository.getSuwar();

      for (var i = 0; i < suwar.length; i++) {
        final progress = i / (suwar.length - 1);
        yield ActivePageSuwarDownloading(progress);

        final surah = suwar[i];
        await tafsirRepository.getAayaat(surah);

        await DefaultCacheManager().getSingleFile('$_images/${surah.image}');
      }

      yield ActivePageSuwar(null);
    }
  }
}
