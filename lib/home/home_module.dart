import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/home/ui/home_page.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ds/suwar_ds.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Api(Client())),
        Bind.singleton((i) => SuwarDataSource(i(), i())),
        Bind.singleton((i) => SuwarBloc(i())..add(const SuwarEvent.load())),
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
