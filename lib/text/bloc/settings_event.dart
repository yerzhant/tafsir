part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsChanged extends SettingsEvent {
  final double fontSize;
  final bool showTranslation;
  final bool showTafsir;

  SettingsChanged(this.fontSize, this.showTranslation, this.showTafsir);
}
