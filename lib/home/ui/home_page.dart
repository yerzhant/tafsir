import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/ui/bookmarks_list.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/offline/bloc/offline_bloc.dart';
import 'package:tafsir/search/ui/search_dialog.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_list.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    Modular.get<SuwarBloc>().add(const SuwarEvent.load());
    Modular.get<BookmarksBloc>().add(const BookmarksEvent.load());
    _openSavedPosition();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Суры'),
              Tab(text: 'Закладки'),
            ],
          ),
          actions: _actions(context),
          title: const Text('Тафсир Azan.ru'),
        ),
        body: const TabBarView(
          children: [
            SuwarList(),
            BookmarksList(),
          ],
        ),
      ),
    );
  }

  Future<void> _openSavedPosition() async {
    final settings = Modular.get<SettingsRepo>();
    final savedPosition = await settings.getSavedTextPosition();
    if (savedPosition != null) {
      final db = Modular.get<TafsirDB>();
      final surah = await db.getSurahByWeight(savedPosition.surahWeight);
      Modular.to.pushNamed(
        '/text/0/${savedPosition.index}/${savedPosition.leadingEdge}',
        arguments: surah,
      );
    }
  }

  List<Widget> _actions(BuildContext context) => [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => SearchDialog(Modular.get()),
            );
          },
          icon: const Icon(Icons.search),
        ),
        BlocBuilder<ThemeCubit, ThemeState>(
          bloc: Modular.get(),
          builder: (context, state) {
            return PopupMenuButton<_Actions>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: _Actions.offline,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/offline.svg',
                        color: state.appMenuIcon,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Offline режим',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _Actions.share,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/share.svg',
                        color: state.appMenuIcon,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Поделиться',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _Actions.azanRu,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/logo.png',
                        // width: 16.67,
                        height: 20,
                        color: state.appMenuIcon,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Azan.ru',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (action) {
                switch (action) {
                  case _Actions.offline:
                    Modular.get<OfflineBloc>()
                        .add(const OfflineEvent.download());
                    Modular.to.pushNamed('offline');
                    break;

                  case _Actions.share:
                    _share();
                    break;

                  case _Actions.azanRu:
                    launch('https://azan.ru');
                    break;
                }
              },
            );
          },
        ),
      ];

  Future<void> _share() async {
    var text = 'Тафсир Корана\n\n';

    text += Platform.isIOS
        ? 'https://apps.apple.com/app/id1542515717'
        : 'https://play.google.com/store/apps/details?id=ru.azan.tafsir';

    await Share.share(text, subject: 'Тафсир Корана');
  }
}

enum _Actions { offline, share, azanRu }
