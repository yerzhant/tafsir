import 'package:sqflite/sqflite.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

const _surahTableName = 'surah';
const _textTableName = 'aayah';

class TafsirDB {
  late Database _db;

  Future<List<Map<String, dynamic>>> getSuwar() =>
      _db.query(_surahTableName, orderBy: 'weight');

  Future<List<Map<String, dynamic>>> getTextItems(Surah surah) => _db.query(
        _textTableName,
        where: 'surah_id = ?',
        whereArgs: [surah.id],
        orderBy: 'weight',
      );

  Future<void> _insertSurah(Surah surah) =>
      _db.insert(_surahTableName, surah.toMap());

  Future<void> insertSuwar(List<Surah> suwar) async {
    for (final surah in suwar) {
      await _insertSurah(surah);
    }
  }

  Future<void> _insertTextItem(TextItem item) =>
      _db.insert(_textTableName, item.toMap());

  Future<void> insertTextItems(List<TextItem> items) async {
    for (final item in items) {
      await _insertTextItem(item);
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
