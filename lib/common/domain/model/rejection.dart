import 'package:freezed_annotation/freezed_annotation.dart';

part 'rejection.freezed.dart';

@freezed
class Rejection with _$Rejection {
  @Assert('reason.trim().isNotEmpty', 'reason may not be empty')
  factory Rejection(String reason) = _Rejection;

  Rejection._();

  String get message => _messages.entries
      .firstWhere(
        (entry) => RegExp(entry.key).hasMatch(reason),
        orElse: () => MapEntry('', reason),
      )
      .value;
}

extension RejectionExt on Exception {
  Rejection asRejection() => Rejection(toString());
}

const _messages = {
  'SocketException: .*': 'Ошибка соединения.',
};
