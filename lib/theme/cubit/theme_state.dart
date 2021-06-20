part of 'theme_cubit.dart';

class ThemeState {
  final Brightness brightness;
  final Color text;
  final Color primary;
  final Color primaryVariant;
  final Color background;
  final Color divider;
  final Color listItemTitle;
  final Color listItemSubtitle;
  final Color listItemNumberBox;
  final Color lightThemeButtonText;
  final Color dartThemeButtonText;
  final Color appMenuIcon;
  final Color appBarBackground;
  final Color toolsBackground;
  final Color toolControlsBackground;
  final Color translationBackground;

  ThemeState({
    required this.brightness,
    required this.text,
    required this.primary,
    required this.primaryVariant,
    required this.background,
    required this.divider,
    required this.listItemTitle,
    required this.listItemSubtitle,
    required this.listItemNumberBox,
    required this.lightThemeButtonText,
    required this.dartThemeButtonText,
    required this.appMenuIcon,
    required this.appBarBackground,
    required this.toolsBackground,
    required this.toolControlsBackground,
    required this.translationBackground,
  });

  static final light = ThemeState(
    brightness: Brightness.light,
    text: const Color(0xff060d1b),
    primary: const Color(0xff0088c7),
    primaryVariant: const Color(0xffc9e6f3),
    background: const Color(0xffffffff),
    divider: const Color(0x4dbdbdc2),
    listItemTitle: const Color(0xff0a0a0a),
    listItemSubtitle: const Color(0xffbdbdc2),
    listItemNumberBox: const Color(0xffbdbdc2),
    lightThemeButtonText: const Color(0xff060d1b),
    dartThemeButtonText: const Color(0x80ffffff),
    appMenuIcon: const Color(0xffbdbdc2),
    appBarBackground: const Color(0xff0088c7),
    toolsBackground: const Color(0xffffffff),
    toolControlsBackground: const Color(0x7fe5e5e5),
    translationBackground: const Color(0x33bdbdc2),
  );

  static final dark = ThemeState(
    brightness: Brightness.dark,
    text: const Color(0xffffffff),
    primary: const Color(0xff0088c7),
    primaryVariant: const Color(0xffc9e6f3),
    background: const Color(0xff131f29),
    divider: const Color(0x17bdbdc2),
    listItemTitle: const Color(0xffffffff),
    listItemSubtitle: const Color(0x4dffffff),
    listItemNumberBox: const Color(0x4dbdbdc2),
    lightThemeButtonText: const Color(0xffbdbdc2),
    dartThemeButtonText: const Color(0xffffffff),
    appMenuIcon: const Color(0xffffffff),
    appBarBackground: const Color(0xff25303a),
    toolsBackground: const Color(0xff25303a),
    toolControlsBackground: const Color(0xff1a232a),
    translationBackground: const Color(0x1affffff),
  );
}
