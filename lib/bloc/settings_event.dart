part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsLoad extends SettingsEvent {}

class SettingsSave extends SettingsEvent {
  final bool isDisplayAlwaysOn;

  const SettingsSave(this.isDisplayAlwaysOn);
}
