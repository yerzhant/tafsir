part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageEvent {}

class ActivePageSuwarShown extends ActivePageEvent {}

class ActivePageTextShown extends ActivePageEvent {
  final Surah surah;
  final int aayah;

  ActivePageTextShown(this.surah, this.aayah);
}

class ActivePageBookmarksShown extends ActivePageEvent {}
