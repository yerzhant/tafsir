part of 'theme_bloc.dart';

const _primaryColorLight = const Color(0xFF536DFE);
const _primaryColorDark = const Color(0xFF3949AB);

const _textColorLight = const Color(0xFF414141);
const _textColorDark = const Color(0xFFE0E0E0);

const _activeSurahItemBackgroundColorLight = const Color(0xFFDBE1FF);
const _activeSurahItemBackgroundColorDark = const Color(0xFF202020);

const _aayahBackgroundColorLight = const Color(0xffeef5f7);
const _aayahBackgroundColorDark = const Color(0xff272c30);

const _aayahBlockquoteBlueBgLight = '#eef5ff';
const _aayahBlockquoteBlueBgDark = '#29343d';

const _aayahBlockquoteGreenBgLight = '#f5fffa';
const _aayahBlockquoteGreenBgDark = '#2c362b';

const _aayahFootnoteBgLight = '#eef5f7';
const _aayahFootnoteBgDark = '#26251f';

const _aayahSpecDivBgLight = '#f5f5f5';
const _aayahSpecDivBgDark = '#282828';

@immutable
abstract class ThemeState {
  final ThemeData themeData;
  final Color activeSurahItemBackgroundColor;
  final Color aayahBackgroundColor;
  final String aayahBlockquoteBlueBg;
  final String aayahBlockquoteGreenBg;
  final String aayahFootnoteBg;
  final String aayahSpecDivBg;

  ThemeState(
    this.themeData,
    this.activeSurahItemBackgroundColor,
    this.aayahBackgroundColor,
    this.aayahBlockquoteBlueBg,
    this.aayahBlockquoteGreenBg,
    this.aayahFootnoteBg,
    this.aayahSpecDivBg,
  );
}

class ThemeLight extends ThemeState {
  ThemeLight()
      : super(
          ThemeData(
            brightness: Brightness.light,
            primaryColor: _primaryColorLight,
            accentColor: _primaryColorLight,
            textTheme: TextTheme(bodyText2: TextStyle(color: _textColorLight)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _activeSurahItemBackgroundColorLight,
          _aayahBackgroundColorLight,
          _aayahBlockquoteBlueBgLight,
          _aayahBlockquoteGreenBgLight,
          _aayahFootnoteBgLight,
          _aayahSpecDivBgLight,
        );
}

class ThemeDark extends ThemeState {
  ThemeDark()
      : super(
          ThemeData(
            brightness: Brightness.dark,
            primaryColor: _primaryColorDark,
            accentColor: _primaryColorDark,
            textTheme: TextTheme(bodyText2: TextStyle(color: _textColorDark)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _activeSurahItemBackgroundColorDark,
          _aayahBackgroundColorDark,
          _aayahBlockquoteBlueBgDark,
          _aayahBlockquoteGreenBgDark,
          _aayahFootnoteBgDark,
          _aayahSpecDivBgDark,
        );
}
