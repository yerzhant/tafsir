import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bookmarks/ui/bookmarks_page.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_page.dart';
import 'package:tafsir/text/ui/text_page.dart';

const _suwarPageIndex = 0;
const _textPageIndex = _suwarPageIndex + 1;
const _bookmarksPageIndex = _textPageIndex + 1;

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key key}) : super(key: key);

  @override
  _NavigatorWidgetState createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  int _currentPageIndex = _suwarPageIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivePageBloc, ActivePageState>(
      listener: (_, state) {
        if (state is ActivePageSuwar)
          setState(() {
            _currentPageIndex = _suwarPageIndex;
          });
        else if (state is ActivePageText)
          setState(() {
            _currentPageIndex = _textPageIndex;
          });
        else if (state is ActivePageBookmarks)
          setState(() {
            _currentPageIndex = _bookmarksPageIndex;
          });
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ActivePageBloc, ActivePageState>(
            builder: (_, state) {
              if (state is ActivePageText)
                return Text(state.surah.title);
              else
                return Text('Тафсир');
            },
          ),
        ),
        body: BlocBuilder<ActivePageBloc, ActivePageState>(
          builder: (_, state) {
            if (state is ActivePageSuwar)
              return SuwarPage();
            else if (state is ActivePageText)
              return TextPage(surah: state.surah);
            else if (state is ActivePageBookmarks)
              return BookmarksPage();
            else
              return null;
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Суры'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              title: Text('Текст'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              title: Text('Закладки'),
            ),
          ],
          currentIndex: _currentPageIndex,
          onTap: (index) {
            ActivePageEvent event;

            switch (index) {
              case _suwarPageIndex:
                event = ActivePageSuwarShown();
                break;

              case _textPageIndex:
                final surah =
                    BlocProvider.of<ActivePageBloc>(context).state.surah;
                event = ActivePageTextShown(surah);
                break;

              case _bookmarksPageIndex:
                event = ActivePageBookmarksShown();
                break;
            }

            BlocProvider.of<ActivePageBloc>(context).add(event);
          },
        ),
      ),
    );
  }
}
