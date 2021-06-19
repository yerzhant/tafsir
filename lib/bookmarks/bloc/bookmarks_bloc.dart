import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/bookmarks/domain/model/bookmark.dart';
import 'package:tafsir/bookmarks/repo/bookmark_repo.dart';
import 'package:tafsir/common/domain/model/rejection.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';
part 'bookmarks_bloc.freezed.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  final BookmarkRepository repo;

  BookmarksBloc(this.repo) : super(const _InProgress());

  @override
  Stream<BookmarksState> mapEventToState(BookmarksEvent event) => event.when(
        load: _load,
        add: _add,
        remove: _remove,
      );

  Stream<BookmarksState> _load() async* {
    yield const _InProgress();

    final result = await repo.getAll();

    yield result.fold(
      (l) => _Error(l),
      (r) => _State(r),
    );
  }

  Stream<BookmarksState> _add(Bookmark bookmark) async* {
    yield const _InProgress();

    final result = await repo.add(bookmark);

    yield result.fold(
      (l) => _Error(l),
      (r) => _State(r),
    );
  }

  Stream<BookmarksState> _remove(Bookmark bookmark) async* {
    yield const _InProgress();

    final result = await repo.remove(bookmark);

    yield result.fold(
      (l) => _Error(l),
      (r) => _State(r),
    );
  }
}
