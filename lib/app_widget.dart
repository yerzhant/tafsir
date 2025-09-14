import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

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
      primaryColor: theme.primary,
      textTheme: Theme.of(context).textTheme.copyWith(
            headlineMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.text,
            ),
            headlineSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.listItemTitle,
            ),
            titleLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.listItemTitle,
            ),
            titleMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: theme.listItemSubtitle,
            ),
            titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.listItemTitle,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: theme.appBarBackground,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(color: theme.appMenuBackground),
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.white,
        dividerColor: Colors.transparent,
      ),
      colorScheme: ColorScheme(
        primary: theme.primary,
        secondary: theme.secondary,
        surface: theme.background,
        error: Colors.red,
        onPrimary: Colors.red,
        onSecondary: Colors.red,
        onSurface: theme.lightThemeButtonText,
        onError: Colors.red,
        brightness: theme.brightness,
      ),
      canvasColor: theme.background,
      dividerTheme: DividerThemeData(color: theme.divider),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: theme.primary,
      ),
    );
  }
}
