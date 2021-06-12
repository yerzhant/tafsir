import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/home/ui/home_page.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ds/suwar_ds.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => SuwarDataSource(i(), i())),
        Bind.singleton((i) => SuwarBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(
            suwarBloc: Modular.get(),
          ),
        ),
      ];
}
