part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final double aayahFontSize;
  final double fontSize;
  final bool showTranslation;
  final bool showTafsir;

  SettingsState(
    this.aayahFontSize,
    this.fontSize,
    this.showTranslation,
    this.showTafsir,
  );
}
