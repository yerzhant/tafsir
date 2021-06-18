part of 'theme_cubit.dart';

class ThemeState {
  final Brightness brightness;
  final Color text;
  final Color primary;
  final Color listItemTitle;
  final Color listItemSubtitle;
  final Color listItemDivider;
  final Color listItemNumberBox;
  final Color lightThemeButtonText;
  final Color dartThemeButtonText;
  final Color toolsBackground;

  ThemeState({
    required this.brightness,
    required this.text,
    required this.primary,
    required this.listItemTitle,
    required this.listItemSubtitle,
    required this.listItemDivider,
    required this.listItemNumberBox,
    required this.lightThemeButtonText,
    required this.dartThemeButtonText,
    required this.toolsBackground,
  });

  static final light = ThemeState(
    brightness: Brightness.light,
    text: const Color(0xff060d1b),
    primary: const Color(0xff0088c7),
    listItemTitle: const Color(0xff0a0a0a),
    listItemSubtitle: const Color(0xffbdbdc2),
    listItemDivider: const Color(0x4dbdbdc2),
    listItemNumberBox: const Color(0xffbdbdc2),
    lightThemeButtonText: const Color(0xff060d1b),
    dartThemeButtonText: const Color(0x80ffffff),
    toolsBackground: const Color(0xffffffff),
  );

  static final dark = ThemeState(
    brightness: Brightness.dark,
    text: const Color(0xffffffff),
    primary: const Color(0xff0088c7),
    listItemTitle: const Color(0xffffffff),
    listItemSubtitle: const Color(0x4dffffff),
    listItemDivider: const Color(0x17bdbdc2),
    listItemNumberBox: const Color(0x4dbdbdc2),
    lightThemeButtonText: const Color(0xffbdbdc2),
    dartThemeButtonText: const Color(0xffffffff),
    toolsBackground: const Color(0xff25303a),
  );
}
