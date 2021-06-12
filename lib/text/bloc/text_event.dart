part of 'text_bloc.dart';

@freezed
class TextEvent with _$TextEvent {
  const factory TextEvent.load(Surah surah) = _Load;
}
