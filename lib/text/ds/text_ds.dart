import 'package:tafsir/common/ds/api.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';
import 'package:tafsir/text/domain/repo/text_repo.dart';

class TextDataSource implements TextRepo {
  final TafsirDB db;
  final Api api;

  const TextDataSource(this.db, this.api);

  @override
  Future<Either<Rejection, List<TextItem>>> getItems(Surah surah) async {
    final list = await db.getTextItems(surah);

    if (surah.ayatsCount != null && list.isEmpty) {
      final result = await api.getList(
        'aayaat?surah=${surah.id}',
        (map) => TextItem.fromMap(map),
      );

      return result.fold(
        (l) => left(l),
        (r) async {
          await db.insertTextItems(r);
          return right(r);
        },
      );
    }

    return right(list.map((e) => TextItem.fromMap(e)).toList());
  }
}
