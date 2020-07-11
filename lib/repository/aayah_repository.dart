import 'package:sqflite/sqflite.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';

import 'api.dart';

const _tableName = 'aayah';

class AayahRepository {
  final Database db;

  AayahRepository(this.db);

  Future<void> _insert(Aayah aayah) async {
    await db.insert(_tableName, aayah.toMap());
  }

  void _insertAll(List<Aayah> aayaat) {
    aayaat.forEach((e) async => await _insert(e));
  }

  Future<void> deleteAll() async {
    await db.delete(_tableName);
  }

  Future<List<Aayah>> getAll(Surah surah) async {
    final list = await db.query(
      _tableName,
      where: 'surah_id = ?',
      whereArgs: [surah.id],
      orderBy: 'title',
    );

    if (list.length == 0) {
      final aayaat = await apiGet(
        'aayaat?surah=${surah.id}',
        (map) => Aayah.fromMap(map),
      );
      _insertAll(aayaat);
      return aayaat;
    }

    return list.map((e) => Aayah.fromMap(e)).toList();
  }
}
