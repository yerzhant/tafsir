import 'package:sqflite/sqflite.dart';
import 'package:tafsir/repository/surah_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';

class TafsirRepository {
  Database _db;
  SurahRepository _surahRepository;

  Future<void> init() async {
    _db = await openDatabase(
      'app.db',
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
        create table surah(
          id integer primary key,
          weight integer not null,
          title text not null,
          title_in_russian text,
          text text,
          ayats_count integer,
          dzhuz text,
          reveal_order integer,
          image text
        )
      ''');
      },
    );

    _surahRepository = SurahRepository(_db);
  }

  Future<void> close() => _db.close();

  Future<List<Surah>> getSuwar() {
    return _surahRepository.getAll();
  }
}
