import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/domain/model/bookmark.dart';

class BookmarkItem extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkItem(this.bookmark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Modular.to.pushNamed('/text', arguments: surah);
      },
      child: Dismissible(
        key: Key(bookmark.id.toString()),
        background: Container(color: Theme.of(context).primaryColor),
        onDismissed: (_) =>
            context.read<BookmarksBloc>().add(BookmarksEvent.remove(bookmark)),
        child: SizedBox(
          height: 74,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x4dbdbdc2)),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/bookmark-filled.svg'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bookmark.surahTitle,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          '${bookmark.aayah} аят',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
