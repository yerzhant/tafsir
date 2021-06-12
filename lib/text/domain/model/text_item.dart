class TextItem {
  final int id;
  final int surahId;
  final int weight;
  final String title;
  final String textOrigin;
  final String text;
  final String tafsir;

  const TextItem({
    required this.id,
    required this.surahId,
    required this.weight,
    required this.title,
    required this.textOrigin,
    required this.text,
    required this.tafsir,
  });

  factory TextItem.fromMap(Map<String, dynamic> map) {
    return TextItem(
      id: map['id'] as int,
      surahId: map['surah_id'] as int,
      weight: map['weight'] as int,
      title: map['title'] as String,
      textOrigin: map['text_origin'] as String,
      text: map['text'] as String,
      tafsir: map['tafsir'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'surah_id': surahId,
      'weight': weight,
      'title': title,
      'text_origin': textOrigin,
      'text': text,
      'tafsir': tafsir,
    };
  }
}
