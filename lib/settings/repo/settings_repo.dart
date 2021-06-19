import 'package:shared_preferences/shared_preferences.dart';

const _savedPositionSurahKey = 'saved-position-surah';
const _savedPositionIndexKey = 'saved-position-index';
const _savedPositionLeadingEdgeKey = 'saved-position-leading-edge';

class SettingsRepo {
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
}

class SavedTextPosition {
  final int surahWeight;
  final int index;
  final double leadingEdge;

  const SavedTextPosition(this.surahWeight, this.index, this.leadingEdge);
}
