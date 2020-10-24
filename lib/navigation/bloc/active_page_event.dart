part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageEvent {}

class ActivePageSuwarShown extends ActivePageEvent {}

class ActivePageTextShown extends ActivePageEvent {
  final Surah surah;
  final List<InitialTextPosition> textHistory;
  final int aayah;
  final int initialIndex;
  final double initialLeadingEdge;

  ActivePageTextShown(
    this.surah,
    this.textHistory,
    this.aayah, {
    this.initialIndex = 0,
    this.initialLeadingEdge = 0,
  });
}

class ActivePageTextScrolledTo extends ActivePageTextShown {
  final Set<Bookmark> bookmarks;

  ActivePageTextScrolledTo(
    Surah surah,
    List<InitialTextPosition> textHistory,
    this.bookmarks,
    int aayah,
  ) : super(surah, textHistory, aayah);
}

class ActivePageBookmarksShown extends ActivePageEvent {}

class ActivePageSearchShown extends ActivePageEvent {}

class ActivePageSuwarDownloaded extends ActivePageEvent {}
