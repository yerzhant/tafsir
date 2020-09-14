import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const _defaultAayahFontSize = 34.0;
const _defaultFontSize = 16.0;

const _aayahFontSizeKey = 'aayah-font-size';
const _textFontSizeKey = 'text-font-size';

const _showTranslationKey = 'show-translation';
const _showTafsirKey = 'show-tafsir';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc._(SettingsState state) : super(state);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is SettingsChanged) {
      prefs.setDouble(_aayahFontSizeKey, event.aayahFontSize);
      prefs.setDouble(_textFontSizeKey, event.fontSize);
      prefs.setBool(_showTranslationKey, event.showTranslation);
      prefs.setBool(_showTafsirKey, event.showTafsir);

      yield SettingsState(
        event.aayahFontSize,
        event.fontSize,
        event.showTranslation,
        event.showTafsir,
      );
    }
  }

  static Future<SettingsBloc> create() async {
    final prefs = await SharedPreferences.getInstance();

    final aayahfontSize =
        prefs.getDouble(_aayahFontSizeKey) ?? _defaultAayahFontSize;
    final fontSize = prefs.getDouble(_textFontSizeKey) ?? _defaultFontSize;
    final showTranslation = prefs.getBool(_showTranslationKey) ?? true;
    final showTafsir = prefs.getBool(_showTafsirKey) ?? true;

    return SettingsBloc._(
      SettingsState(
        aayahfontSize,
        fontSize,
        showTranslation,
        showTafsir,
      ),
    );
  }
}