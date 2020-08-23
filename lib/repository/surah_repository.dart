import 'package:sqflite/sqflite.dart';
import 'package:tafsir/suwar/model/surah.dart';

import 'api.dart';

const _tableName = 'surah';

class SurahRepository {
  final Database db;

  SurahRepository(this.db);

  Future<void> _insert(Surah surah) async {
    await db.insert(_tableName, surah.toMap());
  }

  void _insertAll(List<Surah> suwar) {
    suwar.forEach((e) async => await _insert(e));
  }

  Future<void> deleteAll() async {
    await db.delete(_tableName);
  }

  Future<List<Surah>> getAll() async {
    final list = await db.query(_tableName, orderBy: 'weight');

    if (list.length == 0) {
      final suwar = await apiGet('suwar', (map) => Surah.fromMap(map));
      _insertAll(suwar);
      return suwar;
    }

    return list.map((e) => Surah.fromMap(e)).toList();
  }

  Future<Surah> getSurahById(int surahId) async {
    final list = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [surahId],
    );
    return list.map((e) => Surah.fromMap(e)).first;
  }

  Future<Surah> getSurahByWeight(int weight) async {
    final list = await db.query(
      _tableName,
      where: 'weight = ?',
      whereArgs: [weight],
    );
    return list.map((e) => Surah.fromMap(e)).first;
  }

  Future<Surah> getBySlug(String slug) async {
    final list = await db.query(
      _tableName,
      where: 'slug = ?',
      whereArgs: [slug],
    );
    if (list.isEmpty) return null;
    return list.map((e) => Surah.fromMap(e)).first;
  }
}
