import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/repo/bookmark_repo.dart';
import 'package:tafsir/home/ui/about_us_page.dart';
import 'package:tafsir/home/ui/home_page.dart';
import 'package:tafsir/offline/bloc/offline_bloc.dart';
import 'package:tafsir/offline/ui/offline_page.dart';
import 'package:tafsir/search/bloc/search_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => OfflineBloc(i(), i(), i())),
        Bind.singleton((i) => BookmarkRepository(i())),
        Bind.singleton((i) => BookmarksBloc(i())),
        Bind.singleton((i) => SearchBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
        ChildRoute('/offline', child: (_, __) => const OfflinePage()),
        ChildRoute('/about-us', child: (_, __) => const AboutUsPage()),
      ];
}
