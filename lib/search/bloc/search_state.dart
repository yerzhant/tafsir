part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final String phrase;
  final bool isInAayaat;
  final bool isInTranslation;
  final bool isInTafsir;

  const SearchState(
    this.phrase, {
    this.isInAayaat = true,
    this.isInTranslation = true,
    this.isInTafsir = true,
  });
}

class SearchInitial extends SearchState {
  const SearchInitial() : super('');
}

class SearchInProgress extends SearchState {
  const SearchInProgress() : super('');
}

class SearchSuccess extends SearchState {
  final Set<SearchItem> items;

  const SearchSuccess(
    this.items,
    String phrase, {
    bool isInAayaat = true,
    bool isInTranslation = true,
    bool isInTafsir = true,
  }) : super(
          phrase,
          isInAayaat: isInAayaat,
          isInTranslation: isInTranslation,
          isInTafsir: isInTafsir,
        );
}
