import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafsir/suwar/model/surah.dart';

part 'active_page_event.dart';
part 'active_page_state.dart';

class ActivePageBloc extends Bloc<ActivePageEvent, ActivePageState> {
  ActivePageBloc() : super(ActivePageSuwar(null));

  @override
  Stream<ActivePageState> mapEventToState(ActivePageEvent event) async* {
    if (event is ActivePageSuwarShown) {
      yield ActivePageSuwar(state.surah);
    } else if (event is ActivePageTextShown) {
      yield ActivePageText(event.surah);
    }
  }
}
