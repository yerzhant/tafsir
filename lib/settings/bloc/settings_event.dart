part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.setAayahFontFamily(String family) =
      _SetAayahFontFamily;

  const factory SettingsEvent.setAayahFontSize(double size) = _SetAayahFontSize;
  const factory SettingsEvent.setTextFontSize(double size) = _SetTextFontSize;
  const factory SettingsEvent.setTafsirFontSize(double size) =
      _SetTafsirFontSize;

  const factory SettingsEvent.toggleShowAayaat() = _ToggleShowAayaat;
  const factory SettingsEvent.toggleShowTranslation() = _ToggleShowTranslation;
  const factory SettingsEvent.toggleShowTafsir() = _ToggleShowTafsir;
  const factory SettingsEvent.toggleShowFootnotes() = _ToggleShowFootnotes;

  const factory SettingsEvent.toggleIsDisplayAlwaysOn() =
      _ToggleIsDisplayAlwaysOn;
}
