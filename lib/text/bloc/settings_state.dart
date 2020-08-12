part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final double fontSize;
  final bool showTranslation;
  final bool showTafsir;

  SettingsState(this.fontSize, this.showTranslation, this.showTafsir);
}
