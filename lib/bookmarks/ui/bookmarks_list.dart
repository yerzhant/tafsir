import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/domain/model/bookmark.dart';
import 'package:tafsir/bookmarks/ui/bookmark_item.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';

class BookmarksList extends StatelessWidget {
  const BookmarksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<BookmarksBloc>();

    return BlocBuilder<BookmarksBloc, BookmarksState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
          (bookmarks) => _list(bookmarks, context),
          inProgress: () => const CircularProgress(),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () => bloc.add(const BookmarksEvent.load()),
          ),
        );
      },
    );
  }

  ListView _list(List<Bookmark> bookmarks, BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('bookmarks-list'),
      itemCount: bookmarks.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) => BookmarkItem(bookmarks[index]),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
    );
  }
}
