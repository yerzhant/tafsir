part of 'go_to_aayah_bloc.dart';

@freezed
class GoToAayahState with _$GoToAayahState {
  const factory GoToAayahState.inactive(int number) = _Inactive;
  const factory GoToAayahState.active(double position, int number) = _Active;
  const factory GoToAayahState.semiActive(double position, int number) =
      _SemiActive;
  const factory GoToAayahState.goTo(int number) = _GoTo;
}
