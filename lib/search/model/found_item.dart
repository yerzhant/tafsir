import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

part 'found_item.freezed.dart';

@freezed
class FoundItem with _$FoundItem {
  factory FoundItem(Surah surah, TextItem textItem) = _FoundItem;
}
