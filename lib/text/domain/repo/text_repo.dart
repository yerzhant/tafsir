import 'package:dartz/dartz.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

abstract class TextRepo {
  Future<Either<Rejection, List<TextItem>>> getItems(Surah surah);
}
