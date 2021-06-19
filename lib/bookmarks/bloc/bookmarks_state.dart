part of 'bookmarks_bloc.dart';

@freezed
class BookmarksState with _$BookmarksState {
  const factory BookmarksState(List<Bookmark> items) = _State;
  const factory BookmarksState.inProgress() = _InProgress;
  const factory BookmarksState.error(Rejection rejection) = _Error;
}
