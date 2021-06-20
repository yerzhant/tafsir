import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/ui/bookmarks_list.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_list.dart';

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
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 57,
                height: 50,
              ),
              const Text('Тафсир Azan.ru'),
              const Spacer(),
              IconButton(
                onPressed: () => theFeatureIsPlanned.asSnackBar(context),
                icon: const Icon(Icons.search),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
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
}
