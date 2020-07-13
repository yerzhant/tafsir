part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageEvent {}

class ActivePageSuwarShown extends ActivePageEvent {}

class ActivePageTextShown extends ActivePageEvent {
  final Surah surah;
  final int aayah;

  ActivePageTextShown(this.surah, this.aayah);
}

class ActivePageTextScrolledTo extends ActivePageTextShown {
  final Set<Bookmark> bookmarks;

  ActivePageTextScrolledTo(Surah surah, this.bookmarks, int aayah)
      : super(surah, aayah);
}

class ActivePageBookmarksShown extends ActivePageEvent {}
