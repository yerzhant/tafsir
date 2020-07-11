class Surah {
  final int id;
  final int weight;
  final String title;
  final String titleInRussian;
  final String text;
  final int ayatsCount;
  final String dzhuz;
  final int revealOrder;
  final String image;

  Surah({
    this.id,
    this.weight,
    this.title,
    this.titleInRussian,
    this.text,
    this.ayatsCount,
    this.dzhuz,
    this.revealOrder,
    this.image,
  });

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
      id: map['id'],
      weight: map['weight'],
      title: map['title'],
      titleInRussian: map['title_in_russian'],
      text: map['text'],
      ayatsCount: map['ayats_count'],
      dzhuz: map['dzhuz'],
      revealOrder: map['reveal_order'],
      image: map['image'],
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
      'reveal_order': revealOrder,
      'image': image,
    };
  }
}
