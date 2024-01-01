import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appModule = AppModule();
  await appModule.initialize();

  runApp(ModularApp(module: appModule, child: const AppWidget()));
}
