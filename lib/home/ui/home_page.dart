import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/ui/bookmarks_list.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/common/global_functions.dart';
import 'package:tafsir/offline/bloc/offline_bloc.dart';
import 'package:tafsir/search/ui/search_dialog.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_list.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

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
          icon: SvgPicture.asset('assets/icons/search.svg'),
        ),
        BlocBuilder<ThemeCubit, ThemeState>(
          bloc: Modular.get(),
          builder: (context, state) {
            return PopupMenuButton<_Actions>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                _offlineMenuItem(state, context),
                _shareMenuItem(state, context),
                _evaluateMenuItem(state, context),
                _proposalsMenuItem(state, context),
                _aboutUsMenuItem(state, context),
              ],
              onSelected: (action) {
                switch (action) {
                  case _Actions.offline:
                    Modular.get<OfflineBloc>()
                        .add(const OfflineEvent.download());
                    Modular.to.pushNamed('offline');
                    break;

                  case _Actions.share:
                    shareApp();
                    break;

                  case _Actions.evaluate:
                    evaluateApp();
                    break;

                  case _Actions.proposals:
                    writeToAdmin();
                    break;

                  case _Actions.aboutUs:
                    Modular.to.pushNamed('about-us');
                    break;
                }
              },
            );
          },
        ),
      ];

  PopupMenuItem<_Actions> _aboutUsMenuItem(
      ThemeState state, BuildContext context) {
    return PopupMenuItem(
      value: _Actions.aboutUs,
      child: Row(
        children: [
          const SizedBox(width: 3),
          Image.asset(
            'assets/icons/logo.png',
            height: 20,
            color: state.appMenuIcon,
          ),
          const SizedBox(width: 17.33),
          Text(
            'О нас',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_Actions> _shareMenuItem(
      ThemeState state, BuildContext context) {
    return PopupMenuItem(
      value: _Actions.share,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/share.svg',
            color: state.appMenuIcon,
          ),
          const SizedBox(width: 17.5),
          Text(
            'Поделиться приложением',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_Actions> _evaluateMenuItem(
      ThemeState state, BuildContext context) {
    return PopupMenuItem(
      value: _Actions.evaluate,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/evaluate-app.svg',
            color: state.appMenuIcon,
          ),
          const SizedBox(width: 15.67),
          Text(
            'Оценить приложение',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_Actions> _proposalsMenuItem(
      ThemeState state, BuildContext context) {
    return PopupMenuItem(
      value: _Actions.proposals,
      child: Row(
        children: [
          const SizedBox(width: 2),
          SvgPicture.asset(
            'assets/icons/proposals.svg',
            color: state.appMenuIcon,
          ),
          const SizedBox(width: 16),
          Text(
            'Предложения и замечания',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_Actions> _offlineMenuItem(
      ThemeState state, BuildContext context) {
    return PopupMenuItem(
      value: _Actions.offline,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/offline.svg',
            color: state.appMenuIcon,
          ),
          const SizedBox(width: 15.59),
          Text(
            'Offline режим',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

enum _Actions { offline, share, evaluate, proposals, aboutUs }
