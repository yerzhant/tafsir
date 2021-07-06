part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required String aayahFontFamily,
    required double aayahFontSize,
    required double textFontSize,
    required double tafsirFontSize,
    required bool showAayaat,
    required bool showTranslation,
    required bool showTafsir,
    required bool showFootnotes,
    required bool isDisplayAlwaysOn,
  }) = _State;
}
