part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchActionTapped extends SearchEvent {
  final String phrase;
  final bool isInAayaat;
  final bool isInTranslation;
  final bool isInTafsir;

  SearchActionTapped(
    this.phrase, {
    this.isInAayaat,
    this.isInTranslation,
    this.isInTafsir,
  });
}
