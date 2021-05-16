part of 'theme_bloc.dart';

const _primaryColorLight = Colors.indigoAccent;
final _primaryColorDark = Colors.indigoAccent[200];

const _appBarBgColorLight = _primaryColorLight;
final _appBarBgColorDark = Colors.indigo[600];

final _suwarProgressBgLight = Colors.indigo[50];
const _suwarProgressBgDark = Color(0xff1e1f29);

const _textColorLight = Color(0xFF414141);
const _textColorDark = Color(0xFFE0E0E0);

const _htmlTextColorLight = Color(0xFF414141);
const _htmlTextColorDark = Color(0xFFCCCCCC);

const _activeSurahItemBackgroundColorLight = Color(0xFFDBE1FF);
const _activeSurahItemBackgroundColorDark = Color(0xFF202020);

const _aayahBackgroundColorLight = Color(0xFFEEF5F7);
const _aayahBackgroundColorDark = Color(0xFF2F323A);

const _aayahBlockquoteBlueBgLight = '#EEF5FF';
const _aayahBlockquoteBlueBgDark = '#282A36';

const _aayahBlockquoteGreenBgLight = '#F5FFFA';
const _aayahBlockquoteGreenBgDark = '#243D22';

const _aayahSpecDivBgLight = '#E7EEF8';
const _aayahSpecDivBgDark = '#2A2C36';

const _aayahFootnoteBgLight = '#EEF5F7';
const _aayahFootnoteBgDark = '#2F323A';

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

  const ThemeState(
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
            textTheme:
                const TextTheme(bodyText2: TextStyle(color: _textColorLight)),
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
            textTheme:
                const TextTheme(bodyText2: TextStyle(color: _textColorDark)),
            toggleableActiveColor: _primaryColorDark,
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.indigo[400],
              inactiveTrackColor: Colors.indigo[800],
              thumbColor: const Color(0xFF3949AB),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
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
