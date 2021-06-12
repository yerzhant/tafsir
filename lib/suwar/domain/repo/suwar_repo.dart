import 'package:dartz/dartz.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

abstract class SuwarRepo {
  Future<Either<Rejection, List<Surah>>> getAll();
}
