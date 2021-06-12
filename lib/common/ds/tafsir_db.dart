import 'package:sqflite/sqflite.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

const _surahTableName = 'surah';

class TafsirDB {
  late Database _db;

  Future<List<Map<String, dynamic>>> getAllSuwar() {
    return _db.query(_surahTableName, orderBy: 'weight');
  }

  Future<void> _insert(Surah surah) async {
    await _db.insert(_surahTableName, surah.toMap());
  }

  void insertAll(List<Surah> suwar) {
    for (final s in suwar) {
      _insert(s);
    }
  }

  Future<void> init() async {
    _db = await openDatabase(
      'app.db',
      version: 2,
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
            image text,
            slug text
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
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute('alter table surah add slug text');
          await db.delete('surah');
        }
      },
    );
  }

  Future<void> close() => _db.close();
}
