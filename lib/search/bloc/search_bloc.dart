import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/search/model/found_item.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TafsirDB db;

  SearchBloc(this.db) : super(const _Results('', []));

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) => event.when(
        find: _find,
      );

  Stream<SearchState> _find(String phrase) async* {
    if (phrase.isEmpty || phrase.length < 4) return;

    yield const _InProgress();

    final results = await db.find(phrase);

    if (results.isEmpty) {
      yield const _NotFound();
    } else {
      yield _Results(phrase, await _toFoundItems(results));
    }
  }

  Future<List<FoundItem>> _toFoundItems(Set<TextItem> items) async {
    final foundItems = await Future.wait(items.map((item) async {
      final surah = await db.getSurahById(item.surahId);
      return FoundItem(surah, item);
    }));

    foundItems.sort((i1, i2) {
      if (i1.surah.weight == i2.surah.weight) {
        return i1.textItem.weight - i2.textItem.weight;
      }
      return i1.surah.weight - i2.surah.weight;
    });

    return foundItems.toList();
  }
}
