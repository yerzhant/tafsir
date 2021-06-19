import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/repo/bookmark_repo.dart';
import 'package:tafsir/home/ui/home_page.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ds/suwar_ds.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => SuwarDataSource(i(), i())),
        Bind.singleton((i) => SuwarBloc(i())),
        Bind.singleton((i) => BookmarkRepository(i())),
        Bind.singleton((i) => BookmarksBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
      ];
}
