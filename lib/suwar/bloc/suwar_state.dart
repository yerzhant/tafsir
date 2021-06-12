part of 'suwar_bloc.dart';

@freezed
class SuwarState with _$SuwarState {
  const factory SuwarState(List<Surah> suwar) = _State;
  const factory SuwarState.inProgress() = _InProgress;
  const factory SuwarState.error(Rejection rejection) = _Error;
}
