import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key key}) : super(key: key);

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  Future<List<Bookmark>> _bookmarks;

  @override
  void initState() {
    super.initState();
    _bookmarks = RepositoryProvider.of<TafsirRepository>(context)
        .bookmarkRepository
        .getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bookmark>>(
      future: _bookmarks,
      builder: (_, snap) {
        if (snap.hasData) {
          final bookmarks = snap.data;

          return ListView.separated(
            key: PageStorageKey('bookmarks-list'),
            itemCount: bookmarks.length,
            itemBuilder: (_, index) {
              final bookmark = bookmarks[index];
              return ListTile(
                title: Text(
                  '${bookmark.surahTitle}, ${bookmark.aayah}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onTap: () => _showAayah(context, bookmark),
              );
            },
            separatorBuilder: (_, __) => Divider(height: 1),
          );
        } else if (snap.hasError)
          return Text('Error: ${snap.error}');
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showAayah(BuildContext context, Bookmark bookmark) async {
    final surah = await RepositoryProvider.of<TafsirRepository>(context)
        .getSurahById(bookmark.surahId);

    BlocProvider.of<ActivePageBloc>(context).add(
      ActivePageTextShown(
        surah,
        bookmark.aayah,
      ),
    );
  }
}