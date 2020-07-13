part of 'active_page_bloc.dart';

@immutable
abstract class ActivePageState {
  final Surah surah;

  ActivePageState(this.surah);
}

class ActivePageSuwar extends ActivePageState {
  ActivePageSuwar(Surah surah) : super(surah);
}

class ActivePageText extends ActivePageState {
  ActivePageText(Surah surah) : super(surah);
}
