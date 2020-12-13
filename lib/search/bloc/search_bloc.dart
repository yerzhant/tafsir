import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/search/model/search_item.dart';
import 'package:tafsir/text/model/aayah.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TafsirRepository tafsirRepository;

  SearchBloc(this.tafsirRepository) : super(const SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchActionTapped) {
      yield const SearchInProgress();
      final aayaat = await _findAayaat(event);
      yield SearchSuccess(
        aayaat,
        event.phrase,
        isInAayaat: event.isInAayaat,
        isInTranslation: event.isInTranslation,
        isInTafsir: event.isInTafsir,
      );
    }
  }

  Future<Set<SearchItem>> _findAayaat(SearchActionTapped event) async {
    final aayaat = <Aayah>{};

    final aayahRepository = tafsirRepository.aayahRepository;

    if (event.isInAayaat) {
      final foundSet = await aayahRepository.findInAayaat(event.phrase);
      aayaat.addAll(foundSet);
    }
    if (event.isInTranslation) {
      final foundSet = await aayahRepository.findInTranslation(event.phrase);
      aayaat.addAll(foundSet);
    }
    if (event.isInTafsir) {
      final foundSet = await aayahRepository.findInTafsir(event.phrase);
      aayaat.addAll(foundSet);
    }

    if (aayaat.isEmpty) return {};

    final ids = aayaat.map((e) => e.id).toSet();
    aayaat.retainWhere((element) => ids.remove(element.id));

    final items = await Future.wait(aayaat.map((aayah) async {
      final surah = await tafsirRepository.getSurahById(aayah.surahId);
      return SearchItem(surah, aayah);
    }));

    items.sort((i1, i2) {
      if (i1.surah.weight == i2.surah.weight) {
        return i1.aayah.weight - i2.aayah.weight;
      }
      return i1.surah.weight - i2.surah.weight;
    });

    return items.toSet();
  }
}
