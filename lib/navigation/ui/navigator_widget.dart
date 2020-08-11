import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/bookmarks/ui/bookmarks_page.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_page.dart';
import 'package:tafsir/text/ui/text_page.dart';
import 'package:url_launcher/url_launcher.dart';

const _suwarPageIndex = 0;
const _textPageIndex = _suwarPageIndex + 1;
const _bookmarksPageIndex = _textPageIndex + 1;

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key key}) : super(key: key);

  @override
  _NavigatorWidgetState createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  final _scrollToAayahController = TextEditingController();

  int _currentPageIndex = _suwarPageIndex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final state = BlocProvider.of<ActivePageBloc>(context).state;

        if (state is ActivePageSuwar) return true;

        BlocProvider.of<ActivePageBloc>(context).add(ActivePageSuwarShown());
        return false;
      },
      child: BlocListener<ActivePageBloc, ActivePageState>(
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
                else if (state is ActivePageSuwarDownloading)
                  return Text('Загрузка...');
                else
                  return Text('Тафсир');
              },
            ),
            actions: <Widget>[
              BlocBuilder<ActivePageBloc, ActivePageState>(
                builder: (context, state) {
                  return _getAction(context, state);
                },
              ),
            ],
          ),
          body: BlocBuilder<ActivePageBloc, ActivePageState>(
            builder: (_, state) {
              if (state is ActivePageSuwar)
                return SuwarPage();
              else if (state is ActivePageText)
                return TextPage(surah: state.surah, aayah: state.aayah);
              else if (state is ActivePageBookmarks)
                return BookmarksPage();
              else if (state is ActivePageSuwarDownloading)
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: state.progress,
                        backgroundColor: Colors.indigo[50],
                      ),
                      SizedBox(height: padding),
                      Text(
                        '${((state.progress ?? 0) * 100).toStringAsFixed(2)} %',
                      ),
                    ],
                  ),
                );
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
                  event = ActivePageTextShown(surah, null);
                  break;

                case _bookmarksPageIndex:
                  event = ActivePageBookmarksShown();
                  break;
              }

              BlocProvider.of<ActivePageBloc>(context).add(event);
            },
          ),
        ),
      ),
    );
  }

  Widget _getAction(BuildContext context, ActivePageState state) {
    if (state is ActivePageText && state.surah.isSurah())
      return IconButton(
        tooltip: 'Перейти к аяту',
        icon: Icon(Icons.filter_1, size: iconSize),
        onPressed: () async {
          final String aayah = await showDialog(
            context: context,
            child: AlertDialog(
              content: TextField(
                autofocus: true,
                maxLength: 3,
                controller: _scrollToAayahController,
                decoration: InputDecoration(labelText: 'Перейти к аяту'),
                keyboardType: TextInputType.number,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      _scrollToAayahController.value.text,
                    );
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          );
          if (aayah != null && aayah.isNotEmpty)
            BlocProvider.of<ActivePageBloc>(context).add(
              ActivePageTextScrolledTo(
                state.surah,
                state.bookmarks,
                int.parse(aayah),
              ),
            );
        },
      );
    else if (state is ActivePageSuwar) {
      final isDarkMode = BlocProvider.of<ThemeBloc>(context).state is ThemeDark;

      return PopupMenuButton<_SuwarAction>(
        itemBuilder: (_) => <PopupMenuEntry<_SuwarAction>>[
          const PopupMenuItem(
            child: const Text('Загрузить все суры'),
            value: _SuwarAction.downloadSuwar,
          ),
          PopupMenuItem(
            child: isDarkMode ? Text('Светлый режим') : Text('Темный режим'),
            value: _SuwarAction.switchDarkMode,
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            child: const Text('Azan.ru'),
            value: _SuwarAction.azanRu,
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case _SuwarAction.downloadSuwar:
              BlocProvider.of<ActivePageBloc>(context)
                  .add(ActivePageSuwarDownloaded());
              break;

            case _SuwarAction.switchDarkMode:
              BlocProvider.of<ThemeBloc>(context)
                  .add(isDarkMode ? ThemeLightSelected() : ThemeDarkSelected());
              break;

            case _SuwarAction.azanRu:
              await launch('https://azan.ru');
              break;
          }
        },
      );
    } else
      return Container();
  }
}

enum _SuwarAction { downloadSuwar, switchDarkMode, azanRu }
