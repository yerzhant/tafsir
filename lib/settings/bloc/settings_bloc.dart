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
        setAayahFontSize: _setAayahFontSize,
        setTextFontSize: _setTextFontSize,
        setTafsirFontSize: _setTafsirFontSize,
        toggleShowAayaat: _toggleShowAayaat,
        toggleShowTranslation: _toggleShowTranslation,
        toggleShowTafsir: _toggleShowTafsir,
        toggleShowFootnotes: _toggleShowFootnotes,
        toggleIsDisplayAlwaysOn: _toggleIsDisplayAlwaysOn,
      );

  Stream<SettingsState> _setAayahFontSize(double size) async* {
    final newState = state.copyWith(aayahFontSize: size);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _setTextFontSize(double size) async* {
    final newState = state.copyWith(textFontSize: size);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _setTafsirFontSize(double size) async* {
    final newState = state.copyWith(tafsirFontSize: size);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _toggleShowAayaat() async* {
    final newState = state.copyWith(showAayaat: !state.showAayaat);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _toggleShowTranslation() async* {
    final newState = state.copyWith(showTranslation: !state.showTranslation);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _toggleShowTafsir() async* {
    final newState = state.copyWith(showTafsir: !state.showTafsir);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _toggleShowFootnotes() async* {
    final newState = state.copyWith(showFootnotes: !state.showFootnotes);
    repo.saveState(newState);
    yield newState;
  }

  Stream<SettingsState> _toggleIsDisplayAlwaysOn() async* {
    final newState = state.copyWith(
      isDisplayAlwaysOn: !state.isDisplayAlwaysOn,
    );
    repo.saveState(newState);

    if (state.isDisplayAlwaysOn) {
      await Wakelock.enable();
    } else {
      await Wakelock.disable();
    }

    yield newState;
  }

  static Future<SettingsBloc> create(SettingsRepo repo) async {
    final state = await repo.getState();
    if (state.isDisplayAlwaysOn) await Wakelock.enable();
    return SettingsBloc._(state, repo);
  }
}
