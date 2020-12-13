import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const _isDarkThemeModeKey = 'isDarkThemeMode';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc._(ThemeState state) : super(state);

  static Future<ThemeBloc> create() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkThemeMode = prefs.getBool(_isDarkThemeModeKey);

    if (isDarkThemeMode != null && isDarkThemeMode) {
      return ThemeBloc._(ThemeDark());
    } else {
      return ThemeBloc._(ThemeLight());
    }
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is ThemeLightSelected) {
      await prefs.setBool(_isDarkThemeModeKey, false);
      yield ThemeLight();
    } else if (event is ThemeDarkSelected) {
      await prefs.setBool(_isDarkThemeModeKey, true);
      yield ThemeDark();
    }
  }
}
