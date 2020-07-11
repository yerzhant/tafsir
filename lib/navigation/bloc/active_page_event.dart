part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageEvent {}

class ActivePageSuwarShown extends ActivePageEvent {}

class ActivePageTextShown extends ActivePageEvent {
  final Surah surah;

  ActivePageTextShown(this.surah);
}
