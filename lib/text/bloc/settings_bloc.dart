import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const _defaultAayahFontSize = 34.0;
const _defaultFontSize = 16.0;

const _aayahFontSizeKey = 'aayah-font-size';
const _textFontSizeKey = 'text-font-size';

const _showTranslationKey = 'show-translation';
const _showTafsirKey = 'show-tafsir';
const _isDisplayAlwaysOnKey = 'is-display-always-on';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc._(SettingsState state) : super(state);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is SettingsChanged) {
      await prefs.setDouble(_aayahFontSizeKey, event.aayahFontSize);
      await prefs.setDouble(_textFontSizeKey, event.fontSize);
      await prefs.setBool(_showTranslationKey, event.showTranslation);
      await prefs.setBool(_showTafsirKey, event.showTafsir);
      await prefs.setBool(_isDisplayAlwaysOnKey, event.isDisplayAlwaysOn);

      if (event.isDisplayAlwaysOn) {
        await Wakelock.enable();
      } else {
        await Wakelock.disable();
      }

      yield SettingsState(
        event.aayahFontSize,
        event.fontSize,
        showTranslation: event.showTranslation,
        showTafsir: event.showTafsir,
        isDisplayAlwaysOn: event.isDisplayAlwaysOn,
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
    final isDisplayAlwaysOn = prefs.getBool(_isDisplayAlwaysOnKey) ?? false;

    if (isDisplayAlwaysOn) await Wakelock.enable();

    return SettingsBloc._(
      SettingsState(
        aayahfontSize,
        fontSize,
        showTranslation: showTranslation,
        showTafsir: showTafsir,
        isDisplayAlwaysOn: isDisplayAlwaysOn,
      ),
    );
  }
}
