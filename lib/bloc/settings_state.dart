part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDisplayAlwaysOn;

  const SettingsLoaded(this.isDisplayAlwaysOn);
}
