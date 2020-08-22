part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageState {
  final Surah surah;

  ActivePageState(this.surah);
}

class ActivePageSuwar extends ActivePageState {
  ActivePageSuwar(Surah surah) : super(surah);
}

class ActivePageText extends ActivePageState {
  final Set<Bookmark> bookmarks;
  final int aayah;
  final int initialIndex;
  final double initialLeadingEdge;

  ActivePageText(
    Surah surah,
    this.bookmarks,
    this.aayah,
    this.initialIndex,
    this.initialLeadingEdge,
  ) : super(surah);
}

class ActivePageTextScrollTo extends ActivePageText {
  ActivePageTextScrollTo(Surah surah, Set<Bookmark> bookmarks, int aayah)
      : super(surah, bookmarks, aayah, 0, 0);
}

class ActivePageBookmarks extends ActivePageState {
  final List<Bookmark> bookmarks;

  ActivePageBookmarks(Surah surah, this.bookmarks) : super(surah);
}

class ActivePageSuwarDownloading extends ActivePageState {
  final double progress;

  ActivePageSuwarDownloading(this.progress) : super(null);
}
