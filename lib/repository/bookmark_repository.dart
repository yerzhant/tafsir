import 'package:sqflite/sqflite.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/suwar/model/surah.dart';

const _tableName = 'bookmark';

class BookmarkRepository {
  final Database db;

  BookmarkRepository(this.db);

  Future<Bookmark> insert(Bookmark bookmark) async {
    final id = await db.insert(_tableName, bookmark.toMap());

    return Bookmark(
      id: id,
      surahId: bookmark.surahId,
      surahTitle: bookmark.surahTitle,
      aayah: bookmark.aayah,
    );
  }

  Future<void> delete(Bookmark bookmark) async {
    await db.delete(_tableName, where: 'id = ?', whereArgs: [bookmark.id]);
  }

  Future<List<Bookmark>> getAll() async {
    final list = await db.query(_tableName, orderBy: 'id desc');

    return list.map((e) => Bookmark.fromMap(e)).toList();
  }

  Future<Set<Bookmark>> findBySurah(Surah surah) async {
    final bookmarks = await db.query(
      _tableName,
      where: 'surah_id = ?',
      whereArgs: [surah.id],
    );

    return bookmarks.map((e) => Bookmark.fromMap(e)).toSet();
  }
}
