part of 'suwar_bloc.dart';

@freezed
class SuwarEvent with _$SuwarEvent {
  const factory SuwarEvent.load() = _Load;
  const factory SuwarEvent.updateActiveSurah(Surah surah) = _UpdateActiveSurah;
}
