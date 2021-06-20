part of 'offline_bloc.dart';

@freezed
class OfflineState with _$OfflineState {
  const factory OfflineState(double progress) = _State;
  const factory OfflineState.error(Rejection rejection) = _Error;
}
