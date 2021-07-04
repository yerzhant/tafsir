part of 'go_to_aayah_bloc.dart';

@freezed
class GoToAayahEvent with _$GoToAayahEvent {
  const factory GoToAayahEvent.slidedTo(
    Offset position,
    BuildContext context,
  ) = _SlidedTo;
  const factory GoToAayahEvent.ended() = _Ended;
}
