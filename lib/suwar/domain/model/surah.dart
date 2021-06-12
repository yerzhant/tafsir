class Surah {
  final int id;
  final int weight;
  final String title;
  final String titleInRussian;
  final String text;
  final int ayatsCount;
  final String dzhuz;
  final String revealAt;
  final int revealOrder;
  final String image;
  final String slug;

  const Surah({
    required this.id,
    required this.weight,
    required this.title,
    required this.titleInRussian,
    required this.text,
    required this.ayatsCount,
    required this.dzhuz,
    required this.revealAt,
    required this.revealOrder,
    required this.image,
    required this.slug,
  });

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
      id: map['id'] as int,
      weight: map['weight'] as int,
      title: map['title'] as String,
      titleInRussian: map['title_in_russian'] as String,
      text: map['text'] as String,
      ayatsCount: map['ayats_count'] as int,
      dzhuz: map['dzhuz'] as String,
      revealAt: map['reveal_at'] as String,
      revealOrder: map['reveal_order'] as int,
      image: map['image'] as String,
      slug: map['slug'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'weight': weight,
      'title': title,
      'title_in_russian': titleInRussian,
      'text': text,
      'ayats_count': ayatsCount,
      'dzhuz': dzhuz,
      'reveal_at': revealAt,
      'reveal_order': revealOrder,
      'image': image,
      'slug': slug,
    };
  }

  bool isSurah() => weight > 0;
}
