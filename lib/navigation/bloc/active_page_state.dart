part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageState {}

class ActivePageSuwar extends ActivePageState {}

class ActivePageText extends ActivePageState {
  final Surah surah;

  ActivePageText(this.surah);
}
