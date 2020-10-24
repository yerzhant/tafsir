part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final String phrase;
  final bool isInAayaat;
  final bool isInTranslation;
  final bool isInTafsir;

  const SearchState(
    this.phrase,
    this.isInAayaat,
    this.isInTranslation,
    this.isInTafsir,
  );
}

class SearchInitial extends SearchState {
  SearchInitial() : super('', true, true, true);
}

class SearchInProgress extends SearchState {
  SearchInProgress() : super('', true, true, true);
}

class SearchSuccess extends SearchState {
  final Set<SearchItem> items;

  SearchSuccess(
    this.items,
    String phrase,
    bool isInAayaat,
    bool isInTranslation,
    bool isInTafsir,
  ) : super(phrase, isInAayaat, isInTranslation, isInTafsir);
}
