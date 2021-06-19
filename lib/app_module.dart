import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/home/home_module.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/text/text_module.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class AppModule extends Module {
  final TafsirDB db = TafsirDB();
  final settings = SettingsRepo();

  late final ThemeCubit theme;

  Future<void> init() async {
    theme = await ThemeCubit.create(settings);
    await db.init();
  }

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => db),
        Bind.singleton((i) => theme),
        Bind.singleton((i) => settings),
        Bind.singleton((i) => Api(Client())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/text', module: TextModule()),
      ];

  Future<void> dispose() async => db.close();
}
