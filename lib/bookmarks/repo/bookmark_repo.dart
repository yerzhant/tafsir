import 'package:dartz/dartz.dart';
import 'package:tafsir/bookmarks/domain/model/bookmark.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/common/ds/tafsir_db.dart';

class BookmarkRepository {
  final TafsirDB db;

  const BookmarkRepository(this.db);

  Future<Either<Rejection, List<Bookmark>>> getAll() async {
    try {
      return right(await db.getAllBookmarks());
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  Future<Either<Rejection, List<Bookmark>>> add(Bookmark bookmark) async {
    try {
      await db.insertBookmark(bookmark);
      return getAll();
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  Future<Either<Rejection, List<Bookmark>>> remove(Bookmark bookmark) async {
    try {
      await db.deleteBookmark(bookmark);
      return getAll();
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }
}
