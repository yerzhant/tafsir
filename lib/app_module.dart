import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/home/home_module.dart';

class AppModule extends Module {
  final TafsirDB db = TafsirDB();

  Future<void> init() async => db.init();

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => db),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
      ];

  Future<void> dispose() async => db.close();
}
