part of 'text_bloc.dart';

@freezed
class TextState with _$TextState {
  const factory TextState(List<TextItem> items) = _State;
  const factory TextState.inProgress() = _InProgress;
  const factory TextState.error(Rejection rejection) = _Error;
}
