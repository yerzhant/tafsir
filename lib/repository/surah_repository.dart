import 'package:sqflite/sqflite.dart';
import 'package:tafsir/suwar/model/surah.dart';

import 'api.dart';

const _tableName = 'surah';

class SurahRepository {
  final Database db;

  SurahRepository(this.db);

  void _insert(Surah surah) async {
    await db.insert(_tableName, surah.toMap());
  }

  void _insertAll(List<Surah> suwar) {
    suwar.forEach((e) => _insert(e));
  }

  void deleteAll() async {
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
}
