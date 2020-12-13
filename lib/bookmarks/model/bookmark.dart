class Bookmark {
  final int id;
  final int surahId;
  final String surahTitle;
  final int aayah;

  const Bookmark({
    this.id,
    this.surahId,
    this.surahTitle,
    this.aayah,
  });

  const Bookmark.autogenerate({
    this.surahId,
    this.surahTitle,
    this.aayah,
  }) : id = null;

  Bookmark.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        surahId = map['surah_id'] as int,
        surahTitle = map['surah_title'] as String,
        aayah = map['aayah'] as int;

  Map<String, dynamic> toMap() {
    final fields = <String, dynamic>{
      'surah_id': surahId,
      'surah_title': surahTitle,
      'aayah': aayah,
    };

    if (id != null) fields['id'] = id;

    return fields;
  }
}
