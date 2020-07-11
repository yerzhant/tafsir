import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_page.dart';
import 'package:tafsir/text/ui/text_page.dart';

const _suwarPageIndex = 0;
const _textPageIndex = _suwarPageIndex + 1;
// const _bookmarksPage = _textPage + 1;

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
      listener: (context, state) {
        if (state is ActivePageSuwar)
          setState(() {
            _currentPageIndex = _suwarPageIndex;
          });
        else if (state is ActivePageText)
          setState(() {
            _currentPageIndex = _textPageIndex;
          });
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Тафсир')),
        body: _getCurrentPage(),
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
                event = ActivePageTextShown(null);
                break;
            }
            BlocProvider.of<ActivePageBloc>(context).add(event);
          },
        ),
      ),
    );
  }

  Widget _getCurrentPage() {
    if (_currentPageIndex == _suwarPageIndex)
      return SuwarPage();
    else if (_currentPageIndex == _textPageIndex)
      return TextPage();
    else
      return null;
  }
}
