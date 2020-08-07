import 'package:sqflite/sqflite.dart';
import 'package:tafsir/repository/aayah_repository.dart';
import 'package:tafsir/repository/bookmark_repository.dart';
import 'package:tafsir/repository/surah_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';

class TafsirRepository {
  Database _db;
  SurahRepository _surahRepository;
  AayahRepository _aayahRepository;
  BookmarkRepository _bookmarkRepository;

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
            text_origin text not null,
            surah_id integer not null,
            weight integer not null,
            title text not null,
            text text not null,
            tafsir text
          )
        ''');

        await db.execute('''
          create table bookmark(
            id integer primary key autoincrement,
            surah_id integer not null,
            surah_title text not null,
            aayah integer not null
          )
        ''');
      },
    );

    _surahRepository = SurahRepository(_db);
    _aayahRepository = AayahRepository(_db);
    _bookmarkRepository = BookmarkRepository(_db);
  }

  Future<void> close() => _db.close();

  Future<List<Surah>> getSuwar() {
    return _surahRepository.getAll();
  }

  Future<List<Aayah>> getAayaat(Surah surah) {
    if (!surah.isSurah()) return Future.value([]);
    return _aayahRepository.getAll(surah);
  }

  Future<void> clearSuwarAndAayaat() async {
    await _aayahRepository.deleteAll();
    await _surahRepository.deleteAll();
  }

  BookmarkRepository get bookmarkRepository => _bookmarkRepository;

  Future<Surah> getSurahById(int surahId) {
    return _surahRepository.getSurahById(surahId);
  }

  Future<Surah> getSurahByWeight(int weight) {
    return _surahRepository.getSurahByWeight(weight);
  }
}
