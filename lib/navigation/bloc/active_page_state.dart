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

  ActivePageText(Surah surah, this.bookmarks) : super(surah);
}

class ActivePageBookmarks extends ActivePageState {
  final List<Bookmark> bookmarks;

  ActivePageBookmarks(Surah surah, this.bookmarks) : super(surah);
}
