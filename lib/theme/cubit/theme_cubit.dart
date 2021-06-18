import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light);

  void light() {
    emit(ThemeState.light);
  }

  void dark() {
    emit(ThemeState.dark);
  }
}
