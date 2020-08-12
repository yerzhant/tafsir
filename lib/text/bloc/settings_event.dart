part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsFontSizeChanged extends SettingsEvent {
  final double fontSize;

  SettingsFontSizeChanged(this.fontSize);
}
