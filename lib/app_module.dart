import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/home/home_module.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:tafsir/text/ds/text_ds.dart';
import 'package:tafsir/text/text_module.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class AppModule extends Module {
  final TafsirDB db = TafsirDB();
  final settings = SettingsRepo();

  late final ThemeCubit theme;
  late final SettingsBloc settingsBloc;

  Future<void> init() async {
    theme = await ThemeCubit.create(settings);
    settingsBloc = await SettingsBloc.create(settings);
    await db.init();
  }

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => db),
        Bind.singleton((i) => theme),
        Bind.singleton((i) => settings),
        Bind.singleton((i) => settingsBloc),
        Bind.singleton((i) => Api(Client())),
        Bind.singleton((i) => TextDataSource(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/text', module: TextModule()),
      ];

  Future<void> dispose() async => db.close();
}
