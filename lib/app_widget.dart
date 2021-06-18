import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, theme) {
        return MaterialApp(
          initialRoute: '/',
          theme: _theme(theme, context),
        ).modular();
      },
    );
  }

  ThemeData _theme(ThemeState theme, BuildContext context) {
    return ThemeData(
      brightness: theme.brightness,
      primaryColor: theme.primary,
      accentColor: theme.primary,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline5: TextStyle(
              fontSize: 16,
              letterSpacing: -.2,
              fontWeight: FontWeight.bold,
              color: theme.listItemTitle,
            ),
            headline6: TextStyle(
              fontSize: 14,
              letterSpacing: -.2,
              fontWeight: FontWeight.bold,
              color: theme.listItemTitle,
            ),
            subtitle1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: theme.listItemSubtitle,
            ),
          ),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      toggleableActiveColor: theme.primary,
      dividerColor: theme.divider,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: theme.primary,
      ),
    );
  }
}
