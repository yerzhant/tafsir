part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageState {
  final Surah surah;
  final List<InitialTextPosition> textHistory;

  const ActivePageState(this.surah, this.textHistory);
}

class ActivePageSuwar extends ActivePageState {
  const ActivePageSuwar(Surah surah, List<InitialTextPosition> textHistory)
      : super(surah, textHistory);
}

class ActivePageText extends ActivePageState {
  final Set<Bookmark> bookmarks;
  final int aayah;
  final int initialIndex;
  final double initialLeadingEdge;

  const ActivePageText(
    Surah surah,
    List<InitialTextPosition> textHistory,
    this.bookmarks,
    this.aayah,
    this.initialIndex,
    this.initialLeadingEdge,
  ) : super(surah, textHistory);
}

class ActivePageTextScrollTo extends ActivePageText {
  const ActivePageTextScrollTo(
    Surah surah,
    List<InitialTextPosition> textHistory,
    Set<Bookmark> bookmarks,
    int aayah,
  ) : super(surah, textHistory, bookmarks, aayah, 0, 0);
}

class ActivePageBookmarks extends ActivePageState {
  final List<Bookmark> bookmarks;

  const ActivePageBookmarks(
    Surah surah,
    List<InitialTextPosition> textHistory,
    this.bookmarks,
  ) : super(surah, textHistory);
}

class ActivePageSearch extends ActivePageState {
  const ActivePageSearch(
    Surah surah,
    List<InitialTextPosition> textHistory,
  ) : super(surah, textHistory);
}

class ActivePageSuwarDownloading extends ActivePageState {
  final double progress;

  const ActivePageSuwarDownloading(this.progress) : super(null, null);
}
