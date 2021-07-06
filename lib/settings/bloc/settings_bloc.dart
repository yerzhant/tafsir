import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
import 'package:wakelock/wakelock.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepo repo;

  SettingsBloc._(SettingsState state, this.repo) : super(state);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) => event.when(
        setAayahFontFamily: _setAayahFontFamily,
        setAayahFontSize: _setAayahFontSize,
        setTextFontSize: _setTextFontSize,
        setTafsirFontSize: _setTafsirFontSize,
        toggleShowAayaat: _toggleShowAayaat,
        toggleShowTranslation: _toggleShowTranslation,
        toggleShowTafsir: _toggleShowTafsir,
        toggleShowFootnotes: _toggleShowFootnotes,
        toggleIsDisplayAlwaysOn: _toggleIsDisplayAlwaysOn,
      );

  Stream<SettingsState> _setAayahFontFamily(String family) =>
      _saveAndYieldState(state.copyWith(aayahFontFamily: family));

  Stream<SettingsState> _setAayahFontSize(double size) =>
      _saveAndYieldState(state.copyWith(aayahFontSize: size));

  Stream<SettingsState> _setTextFontSize(double size) =>
      _saveAndYieldState(state.copyWith(textFontSize: size));

  Stream<SettingsState> _setTafsirFontSize(double size) =>
      _saveAndYieldState(state.copyWith(tafsirFontSize: size));

  Stream<SettingsState> _toggleShowAayaat() =>
      _saveAndYieldState(state.copyWith(showAayaat: !state.showAayaat));

  Stream<SettingsState> _toggleShowTranslation() => _saveAndYieldState(
      state.copyWith(showTranslation: !state.showTranslation));

  Stream<SettingsState> _toggleShowTafsir() =>
      _saveAndYieldState(state.copyWith(showTafsir: !state.showTafsir));

  Stream<SettingsState> _toggleShowFootnotes() =>
      _saveAndYieldState(state.copyWith(showFootnotes: !state.showFootnotes));

  Stream<SettingsState> _toggleIsDisplayAlwaysOn() async* {
    final newState = state.copyWith(
      isDisplayAlwaysOn: !state.isDisplayAlwaysOn,
    );

    if (state.isDisplayAlwaysOn) {
      await Wakelock.enable();
    } else {
      await Wakelock.disable();
    }

    yield* _saveAndYieldState(newState);
  }

  Stream<SettingsState> _saveAndYieldState(SettingsState newState) async* {
    repo.saveState(newState);
    yield newState;
  }

  static Future<SettingsBloc> create(SettingsRepo repo) async {
    final state = await repo.getState();
    if (state.isDisplayAlwaysOn) await Wakelock.enable();
    return SettingsBloc._(state, repo);
  }
}
