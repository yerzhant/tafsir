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

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'],
      weight: json['weight'],
      title: json['title'],
      titleInRussian: json['title_in_russian'],
      text: json['text'],
      ayatsCount: json['ayats_count'],
      dzhuz: json['dzhuz'],
      revealOrder: json['reveal_order'],
      image: json['image'],
    );
  }
}
