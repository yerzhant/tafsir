import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/home/home_module.dart';
import 'package:tafsir/text/text_module.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class AppModule extends Module {
  final TafsirDB db = TafsirDB();

  Future<void> init() async => db.init();

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => db),
        Bind.singleton((i) => Api(Client())),
        Bind.singleton((i) => ThemeCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/text', module: TextModule()),
      ];

  Future<void> dispose() async => db.close();
}
