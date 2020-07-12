class Aayah {
  final int id;
  final int surahId;
  final int weight;
  final String title;
  final String textOrigin;
  final String text;
  final String tafsir;

  const Aayah({
    this.id,
    this.surahId,
    this.weight,
    this.title,
    this.textOrigin,
    this.text,
    this.tafsir,
  });

  factory Aayah.fromMap(Map<String, dynamic> map) {
    return Aayah(
      id: map['id'],
      surahId: map['surah_id'],
      weight: map['weight'],
      title: map['title'],
      textOrigin: map['text_origin'],
      text: map['text'],
      tafsir: map['tafsir'],
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
