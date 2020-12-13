import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc(this.settingsRepository) : super(SettingsLoading());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoad) {
      yield SettingsLoading();
      final isDisplayAlwaysOn = await settingsRepository.isDisplayAlwaysOn();
      yield SettingsLoaded(isDisplayAlwaysOn);
    } else if (event is SettingsSave) {
      yield SettingsLoading();
      await settingsRepository.setIsDisplayAlwaysOn(event.isDisplayAlwaysOn);
      yield SettingsLoaded(event.isDisplayAlwaysOn);
    }
  }
}
