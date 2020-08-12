part of 'theme_bloc.dart';

var _primaryColorLight = Colors.indigoAccent;
var _primaryColorDark = Colors.indigo[600];

const _textColorLight = const Color(0xFF414141);
const _textColorDark = const Color(0xFFE0E0E0);

const _htmlTextColorLight = const Color(0xFF414141);
const _htmlTextColorDark = const Color(0xFFB0B0B0);

const _activeSurahItemBackgroundColorLight = const Color(0xFFDBE1FF);
const _activeSurahItemBackgroundColorDark = const Color(0xFF202020);

const _aayahBackgroundColorLight = const Color(0XFFEEF5F7);
const _aayahBackgroundColorDark = const Color(0XFF272C30);

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
  final Color htmlTextColor;
  final String aayahBlockquoteBlueBg;
  final String aayahBlockquoteGreenBg;
  final String aayahFootnoteBg;
  final String aayahSpecDivBg;

  ThemeState(
    this.themeData,
    this.activeSurahItemBackgroundColor,
    this.aayahBackgroundColor,
    this.htmlTextColor,
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
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.indigoAccent[700],
              inactiveTrackColor: Colors.indigoAccent[100],
              thumbColor: Colors.indigoAccent,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _activeSurahItemBackgroundColorLight,
          _aayahBackgroundColorLight,
          _htmlTextColorLight,
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
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.indigo[400],
              inactiveTrackColor: Colors.indigo[800],
              thumbColor: Color(0xFF3949AB),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _activeSurahItemBackgroundColorDark,
          _aayahBackgroundColorDark,
          _htmlTextColorDark,
          _aayahBlockquoteBlueBgDark,
          _aayahBlockquoteGreenBgDark,
          _aayahFootnoteBgDark,
          _aayahSpecDivBgDark,
        );
}
