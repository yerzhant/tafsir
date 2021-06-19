import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeState theme) : super(theme);

  static Future<ThemeCubit> create(SettingsRepo settings) async {
    final isDark = await settings.isDarkTheme();
    if (isDark) {
      return ThemeCubit(ThemeState.dark);
    } else {
      return ThemeCubit(ThemeState.light);
    }
  }

  void light() {
    emit(ThemeState.light);
    Modular.get<SettingsRepo>().saveIsDarkTheme(isDark: false);
  }

  void dark() {
    emit(ThemeState.dark);
    Modular.get<SettingsRepo>().saveIsDarkTheme();
  }
}
