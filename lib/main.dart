import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/navigation/ui/navigator_widget.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/search/bloc/search_bloc.dart';
import 'package:tafsir/text/bloc/settings_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tafsirRepository = TafsirRepository();
  await tafsirRepository.init();

  runApp(
    TafsirApp(
      tafsirRepository,
      await ActivePageBloc.create(tafsirRepository),
      await ThemeBloc.create(),
      await SettingsBloc.create(),
      await tafsirRepository.getActivePageIndex(),
    ),
  );
}

class TafsirApp extends StatelessWidget {
  final TafsirRepository tafsirRepository;
  final ActivePageBloc activePageBloc;
  final ThemeBloc themeBloc;
  final SettingsBloc settingsBloc;
  final int initialPageIndex;

  const TafsirApp(
    this.tafsirRepository,
    this.activePageBloc,
    this.themeBloc,
    this.settingsBloc,
    this.initialPageIndex,
  );

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
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<ActivePageBloc>(
                    create: (context) => activePageBloc,
                  ),
                  BlocProvider<SettingsBloc>(
                    create: (context) => settingsBloc,
                  ),
                  BlocProvider<SearchBloc>(
                    create: (context) => SearchBloc(tafsirRepository),
                  )
                ],
                child: NavigatorWidget(initialPageIndex: initialPageIndex),
              ),
            ),
          );
        },
      ),
    );
  }
}
