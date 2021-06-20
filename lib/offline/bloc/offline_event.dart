part of 'offline_bloc.dart';

@freezed
class OfflineEvent with _$OfflineEvent {
  const factory OfflineEvent.download() = _Download;
}
