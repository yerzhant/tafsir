import 'package:dartz/dartz.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/suwar/domain/repo/suwar_repo.dart';

class SuwarDataSource implements SuwarRepo {
  final TafsirDB db;
  final Api api;

  const SuwarDataSource(this.db, this.api);

  @override
  Future<Either<Rejection, List<Surah>>> getAll() async {
    final list = await db.getSuwar();

    if (list.isEmpty) {
      final result = await api.getList('suwar', (map) => Surah.fromMap(map));

      return result.fold(
        (l) => left(l),
        (r) async {
          await db.insertSuwar(r);
          return right(r);
        },
      );
    }

    return right(list.map((e) => Surah.fromMap(e)).toList());
  }
}
