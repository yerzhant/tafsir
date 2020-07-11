import 'package:sqflite/sqflite.dart';
import 'package:tafsir/repository/aayah_repository.dart';
import 'package:tafsir/repository/surah_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';

class TafsirRepository {
  Database _db;
  SurahRepository _surahRepository;
  AayahRepository _aayahRepository;

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
            reveal_at text,
            reveal_order integer,
            image text
          )
        ''');

        await db.execute('''
          create table aayah(
            id integer primary key,
            surah_id integer not null,
            title text not null,
            text_origin text not null,
            text text not null,
            tafsir text
          )
        ''');
      },
    );

    _surahRepository = SurahRepository(_db);
    _aayahRepository = AayahRepository(_db);
  }

  Future<void> close() => _db.close();

  Future<List<Surah>> getSuwar() {
    return _surahRepository.getAll();
  }

  Future<List<Aayah>> getAayaat(Surah surah) {
    return _aayahRepository.getAll(surah);
  }
}
