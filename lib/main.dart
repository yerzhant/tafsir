import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/navigation/ui/navigator_widget.dart';
import 'package:tafsir/repository/tafsir_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tafsirRepository = TafsirRepository();
  await tafsirRepository.init();

  runApp(TafsirApp(tafsirRepository, await ThemeBloc.create()));
}

class TafsirApp extends StatelessWidget {
  final TafsirRepository tafsirRepository;
  final ThemeBloc themeBloc;

  TafsirApp(this.tafsirRepository, this.themeBloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Тафсир',
            theme: state.themeData,
            home: RepositoryProvider(
              create: (context) => tafsirRepository,
              child: BlocProvider<ActivePageBloc>(
                create: (context) => ActivePageBloc(tafsirRepository),
                child: NavigatorWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
