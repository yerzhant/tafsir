import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/bloc/text_bloc.dart';
import 'package:tafsir/text/ds/text_ds.dart';
import 'package:tafsir/text/ui/text_page.dart';

class TextModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => TextDataSource(i(), i())),
        Bind.singleton((i) => TextBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/:id',
          child: (_, args) => TextPage(
            bloc: Modular.get(),
            surah: args.data as Surah,
            index: int.parse(args.params['id'] as String),
          ),
        ),
      ];
}
