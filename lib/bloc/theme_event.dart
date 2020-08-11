part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeLightSelected extends ThemeEvent {}

class ThemeDarkSelected extends ThemeEvent {}
