import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/ui/navigator_widget.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';

part 'active_page_event.dart';
part 'active_page_state.dart';

const _images = '$server/media/images/surahs';

class ActivePageBloc extends Bloc<ActivePageEvent, ActivePageState> {
  final TafsirRepository tafsirRepository;

  ActivePageBloc._(ActivePageState state, this.tafsirRepository) : super(state);

  static Future<ActivePageBloc> create(TafsirRepository repository) async {
    final activePageIndex = await repository.getActivePageIndex();

    switch (activePageIndex) {
      case textPageIndex:
        final initialTextPosition = await repository.getInitialTextPosition();
        final surah =
            await repository.getSurahByWeight(initialTextPosition.surahWeight);
        final bookmarks =
            await repository.bookmarkRepository.findBySurah(surah);

        return ActivePageBloc._(
          ActivePageText(
            surah,
            [],
            bookmarks,
            null,
            initialTextPosition.index,
            initialTextPosition.leadingEdge,
          ),
          repository,
        );

      case bookmarksPageIndex:
        final initialTextPosition = await repository.getInitialTextPosition();
        final surah =
            await repository.getSurahByWeight(initialTextPosition.surahWeight);
        final bookmarks = await repository.bookmarkRepository.getAll();

        return ActivePageBloc._(
          ActivePageBookmarks(surah, [], bookmarks),
          repository,
        );

      case searchPageIndex:
        final initialTextPosition = await repository.getInitialTextPosition();
        final surah =
            await repository.getSurahByWeight(initialTextPosition.surahWeight);

        return ActivePageBloc._(
          ActivePageSearch(surah, []),
          repository,
        );

      default:
        return ActivePageBloc._(ActivePageSuwar(null, []), repository);
    }
  }

  @override
  Stream<ActivePageState> mapEventToState(ActivePageEvent event) async* {
    if (event is ActivePageSuwarShown) {
      await tafsirRepository.saveActivePageIndex(suwarPageIndex);
      yield ActivePageSuwar(state.surah, state.textHistory);
    } else if (event is ActivePageTextScrolledTo) {
      await tafsirRepository.saveActivePageIndex(textPageIndex);
      yield ActivePageTextScrollTo(
        event.surah,
        state.textHistory,
        event.bookmarks,
        event.aayah,
      );
    } else if (event is ActivePageTextShown) {
      await tafsirRepository.saveActivePageIndex(textPageIndex);

      var surah = event.surah;

      var initialIndex = event.initialIndex;
      var initialLeadingEdge = event.initialLeadingEdge;

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
        state.textHistory,
        bookmarks,
        event.aayah,
        initialIndex,
        initialLeadingEdge,
      );
    } else if (event is ActivePageBookmarksShown) {
      await tafsirRepository.saveActivePageIndex(bookmarksPageIndex);

      final bookmarks = await tafsirRepository.bookmarkRepository.getAll();
      yield ActivePageBookmarks(state.surah, state.textHistory, bookmarks);
    } else if (event is ActivePageSearchShown) {
      await tafsirRepository.saveActivePageIndex(searchPageIndex);
      yield ActivePageSearch(state.surah, state.textHistory);
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

      yield ActivePageSuwar(null, []);
    }
  }
}
