import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_page.dart';
import 'package:tafsir/text/ui/text_page.dart';

const _suwarPage = 0;
const _textPage = _suwarPage + 1;
const _bookmarksPage = _textPage + 1;

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key key}) : super(key: key);

  @override
  _NavigatorWidgetState createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  int _currentPage = _suwarPage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivePageBloc, ActivePageState>(
      listener: (context, state) {
        if (state is ActivePageSuwar)
          setState(() {
            _currentPage = _suwarPage;
          });
        else if (state is ActivePageText)
          setState(() {
            _currentPage = _textPage;
          });
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Тафсир')),
        body: BlocBuilder<ActivePageBloc, ActivePageState>(
          builder: (context, state) {
            if (state is ActivePageSuwar)
              return SuwarPage();
            else if (state is ActivePageText)
              return TextPage();
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
          currentIndex: _currentPage,
          onTap: (index) {
            ActivePageEvent event;
            switch (index) {
              case _suwarPage:
                event = ActivePageSuwarShown();
                break;
              case _textPage:
                event = ActivePageTextShown(null);
                break;
            }
            BlocProvider.of<ActivePageBloc>(context).add(event);
          },
        ),
      ),
    );
  }
}
