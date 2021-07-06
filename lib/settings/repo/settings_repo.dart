import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';

const _defaultAayahFontFamily = 'KFGQPC Uthman Taha Naskh';

const _defaultAayahFontSize = 34.0;
const _defaultFontSize = 16.0;

const _aayahFontFamilyKey = 'aayah-font-family';

const _aayahFontSizeKey = 'aayah-font-size';
const _textFontSizeKey = 'text-font-size';
const _tafsirFontSizeKey = 'tasfir-font-size';

const _showAayaatKey = 'show-aayaat';
const _showTranslationKey = 'show-translation';
const _showTafsirKey = 'show-tafsir';
const _showFootnotesKey = 'show-footnotes';

const _savedPositionSurahKey = 'saved-position-surah';
const _savedPositionIndexKey = 'saved-position-index';
const _savedPositionLeadingEdgeKey = 'saved-position-leading-edge';

const _isDarkThemeKey = 'is-dark-theme';
const _isDisplayAlwaysOnKey = 'is-display-always-on';

class SettingsRepo {
  Future<SettingsState> getState() async {
    final prefs = await SharedPreferences.getInstance();

    final aayahFontFamily =
        prefs.getString(_aayahFontFamilyKey) ?? _defaultAayahFontFamily;

    final aayahfontSize =
        prefs.getDouble(_aayahFontSizeKey) ?? _defaultAayahFontSize;
    final textFontSize = prefs.getDouble(_textFontSizeKey) ?? _defaultFontSize;
    final tafsirFontSize =
        prefs.getDouble(_tafsirFontSizeKey) ?? _defaultFontSize;

    final showAayaat = prefs.getBool(_showAayaatKey) ?? true;
    final showTranslation = prefs.getBool(_showTranslationKey) ?? true;
    final showTafsir = prefs.getBool(_showTafsirKey) ?? true;
    final showFootnotes = prefs.getBool(_showFootnotesKey) ?? true;

    final isDisplayAlwaysOn = prefs.getBool(_isDisplayAlwaysOnKey) ?? false;

    return SettingsState(
      aayahFontFamily: aayahFontFamily,
      aayahFontSize: aayahfontSize,
      textFontSize: textFontSize,
      tafsirFontSize: tafsirFontSize,
      showAayaat: showAayaat,
      showTranslation: showTranslation,
      showTafsir: showTafsir,
      showFootnotes: showFootnotes,
      isDisplayAlwaysOn: isDisplayAlwaysOn,
    );
  }

  Future<void> saveState(SettingsState state) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_aayahFontFamilyKey, state.aayahFontFamily);
    await prefs.setDouble(_aayahFontSizeKey, state.aayahFontSize);
    await prefs.setDouble(_textFontSizeKey, state.textFontSize);
    await prefs.setDouble(_tafsirFontSizeKey, state.tafsirFontSize);
    await prefs.setBool(_showAayaatKey, state.showAayaat);
    await prefs.setBool(_showTranslationKey, state.showTranslation);
    await prefs.setBool(_showTafsirKey, state.showTafsir);
    await prefs.setBool(_showFootnotesKey, state.showFootnotes);
    await prefs.setBool(_isDisplayAlwaysOnKey, state.isDisplayAlwaysOn);
  }

  Future<void> saveTextPosition(SavedTextPosition textPosition) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt(_savedPositionSurahKey, textPosition.surahWeight);
    prefs.setInt(_savedPositionIndexKey, textPosition.index);
    prefs.setDouble(
      _savedPositionLeadingEdgeKey,
      textPosition.leadingEdge,
    );
  }

  Future<SavedTextPosition?> getSavedTextPosition() async {
    final prefs = await SharedPreferences.getInstance();

    final surah = prefs.getInt(_savedPositionSurahKey);

    if (surah == null) return null;

    return SavedTextPosition(
      prefs.getInt(_savedPositionSurahKey)!,
      prefs.getInt(_savedPositionIndexKey) ?? 0,
      prefs.getDouble(_savedPositionLeadingEdgeKey) ?? 0,
    );
  }

  Future<void> saveIsDarkTheme({bool isDark = true}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkThemeKey, isDark);
  }

  Future<bool> isDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkThemeKey) ?? false;
  }

  Future<bool> isDisplayAlwaysOn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDisplayAlwaysOnKey) ?? false;
  }

  Future<void> setIsDisplayAlwaysOn({bool value = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDisplayAlwaysOnKey, value);
  }
}

class SavedTextPosition {
  final int surahWeight;
  final int index;
  final double leadingEdge;

  const SavedTextPosition(this.surahWeight, this.index, this.leadingEdge);
}
