part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsChanged extends SettingsEvent {
  final double aayahFontSize;
  final double fontSize;
  final bool showTranslation;
  final bool showTafsir;
  final bool isDisplayAlwaysOn;

  SettingsChanged(
    this.aayahFontSize,
    this.fontSize,
    this.showTranslation,
    this.showTafsir,
    this.isDisplayAlwaysOn,
  );
}
