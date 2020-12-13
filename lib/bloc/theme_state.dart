part of 'theme_bloc.dart';

const _primaryColorLight = Colors.indigoAccent;
final _primaryColorDark = Colors.indigoAccent[200];

final _appBarBgColorLight = _primaryColorLight;
final _appBarBgColorDark = Colors.indigo[600];

final _suwarProgressBgLight = Colors.indigo[50];
const _suwarProgressBgDark = Color(0xff1e1f29);

const _textColorLight = const Color(0xFF414141);
const _textColorDark = const Color(0xFFE0E0E0);

const _htmlTextColorLight = const Color(0xFF414141);
const _htmlTextColorDark = const Color(0xFFCCCCCC);

const _activeSurahItemBackgroundColorLight = const Color(0xFFDBE1FF);
const _activeSurahItemBackgroundColorDark = const Color(0xFF202020);

const _aayahBackgroundColorLight = const Color(0XFFEEF5F7);
const _aayahBackgroundColorDark = const Color(0XFF2E3B5B);

const _aayahBlockquoteBlueBgLight = '#EEF5FF';
const _aayahBlockquoteBlueBgDark = '#2A3065';

const _aayahBlockquoteGreenBgLight = '#F5FFFA';
const _aayahBlockquoteGreenBgDark = '#243D22';

const _aayahSpecDivBgLight = '#F5F5F5';
const _aayahSpecDivBgDark = '#3A3A3A';

const _aayahFootnoteBgLight = '#EEF5F7';
const _aayahFootnoteBgDark = '#2E3B5B';

@immutable
abstract class ThemeState {
  final ThemeData themeData;
  final Color appBarBgColor;
  final Color suwarProgressBg;
  final Color activeSurahItemBackgroundColor;
  final Color aayahBackgroundColor;
  final Color htmlTextColor;
  final String aayahBlockquoteBlueBg;
  final String aayahBlockquoteGreenBg;
  final String aayahFootnoteBg;
  final String aayahSpecDivBg;

  ThemeState(
    this.themeData,
    this.appBarBgColor,
    this.suwarProgressBg,
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
            toggleableActiveColor: _primaryColorLight,
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.indigoAccent[700],
              inactiveTrackColor: Colors.indigoAccent[100],
              thumbColor: Colors.indigoAccent,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: _primaryColorLight,
              unselectedItemColor: Colors.grey[700],
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _appBarBgColorLight,
          _suwarProgressBgLight,
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
            toggleableActiveColor: _primaryColorDark,
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.indigo[400],
              inactiveTrackColor: Colors.indigo[800],
              thumbColor: Color(0xFF3949AB),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: _primaryColorLight,
              unselectedItemColor: Colors.grey,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          _appBarBgColorDark,
          _suwarProgressBgDark,
          _activeSurahItemBackgroundColorDark,
          _aayahBackgroundColorDark,
          _htmlTextColorDark,
          _aayahBlockquoteBlueBgDark,
          _aayahBlockquoteGreenBgDark,
          _aayahFootnoteBgDark,
          _aayahSpecDivBgDark,
        );
}
