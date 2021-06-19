part of 'bookmarks_bloc.dart';

@freezed
class BookmarksEvent with _$BookmarksEvent {
  const factory BookmarksEvent.load() = _Load;
  const factory BookmarksEvent.add(Bookmark bookmark) = _Add;
  const factory BookmarksEvent.remove(Bookmark bookmark) = _Remove;
}
