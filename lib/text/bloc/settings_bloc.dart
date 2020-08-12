import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const _defaultFontSize = 16.0;

const _textFontSizeKey = 'text-font-size';

const _showTranslationKey = 'show-translation';
const _showTafsirKey = 'show-tafsir';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc._(SettingsState state) : super(state);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is SettingsChanged) {
      prefs.setDouble(_textFontSizeKey, event.fontSize);
      prefs.setBool(_showTranslationKey, event.showTranslation);
      prefs.setBool(_showTafsirKey, event.showTafsir);

      yield SettingsState(
        event.fontSize,
        event.showTranslation,
        event.showTafsir,
      );
    }
  }

  static Future<SettingsBloc> create() async {
    final prefs = await SharedPreferences.getInstance();

    final fontSize = prefs.getDouble(_textFontSizeKey);

    if (fontSize == null) {
      return SettingsBloc._(SettingsState(_defaultFontSize, true, true));
    }

    final showTranslation = prefs.getBool(_showTranslationKey);
    final showTafsir = prefs.getBool(_showTafsirKey);

    return SettingsBloc._(SettingsState(fontSize, showTranslation, showTafsir));
  }
}
