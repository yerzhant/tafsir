import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const _defaultFontSize = 16.0;

const _textFontSizeKey = 'text-font-size';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc._(SettingsState state) : super(state);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is SettingsFontSizeChanged) {
      prefs.setDouble(_textFontSizeKey, event.fontSize);
      yield SettingsState(event.fontSize);
    }
  }

  static Future<SettingsBloc> create() async {
    final prefs = await SharedPreferences.getInstance();

    final fontSize = prefs.getDouble(_textFontSizeKey);

    if (fontSize == null) {
      return SettingsBloc._(SettingsState(_defaultFontSize));
    }

    return SettingsBloc._(SettingsState(fontSize));
  }
}
