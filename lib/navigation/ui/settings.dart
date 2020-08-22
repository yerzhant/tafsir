import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/text/bloc/settings_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Настройки',
      icon: Icon(Icons.settings, size: iconSize),
      onPressed: () async {
        final settings = await showDialog<SettingsState>(
          context: context,
          child: _Dialog(
            aayahFontSize:
                BlocProvider.of<SettingsBloc>(context).state.aayahFontSize,
            fontSize: BlocProvider.of<SettingsBloc>(context).state.fontSize,
            showTranslation:
                BlocProvider.of<SettingsBloc>(context).state.showTranslation,
            showTafsir: BlocProvider.of<SettingsBloc>(context).state.showTafsir,
            themeState: BlocProvider.of<ThemeBloc>(context).state,
          ),
        );

        if (settings != null) {
          BlocProvider.of<SettingsBloc>(context).add(
            SettingsChanged(
              settings.aayahFontSize,
              settings.fontSize,
              settings.showTranslation,
              settings.showTafsir,
            ),
          );
        }
      },
    );
  }
}

class _Dialog extends StatefulWidget {
  final double aayahFontSize;
  final double fontSize;
  final bool showTranslation;
  final bool showTafsir;
  final ThemeState themeState;

  const _Dialog({
    Key key,
    this.aayahFontSize,
    this.fontSize,
    this.showTranslation,
    this.showTafsir,
    this.themeState,
  }) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  double _aayahFontSize;
  double _fontSize;
  bool _showTranslation;
  bool _showTafsir;

  @override
  void initState() {
    super.initState();
    _aayahFontSize = widget.aayahFontSize;
    _fontSize = widget.fontSize;
    _showTranslation = widget.showTranslation;
    _showTafsir = widget.showTafsir;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Настройки'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 48,
            child: Center(
              child: Text(
                'الله أكبر',
                style: GoogleFonts.scheherazade(fontSize: _aayahFontSize),
              ),
            ),
          ),
          Slider(
            min: 30,
            max: 40,
            value: _aayahFontSize,
            onChanged: (value) {
              setState(() {
                _aayahFontSize = value;
              });
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 24,
            child: Center(
              child: Text(
                'Размер шрифта',
                style: TextStyle(
                  fontSize: _fontSize,
                  color: widget.themeState.htmlTextColor,
                ),
              ),
            ),
          ),
          Slider(
            min: 14,
            max: 20,
            value: _fontSize,
            onChanged: (value) {
              setState(() {
                _fontSize = value;
              });
            },
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('Перевод'),
            value: _showTranslation,
            onChanged: (value) {
              setState(() {
                _showTranslation = value;
              });
            },
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('Тафсир'),
            value: _showTafsir,
            onChanged: (value) {
              setState(() {
                _showTafsir = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ОТМЕНА',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(
              context,
              SettingsState(
                _aayahFontSize,
                _fontSize,
                _showTranslation,
                _showTafsir,
              ),
            );
          },
          child: Text(
            'ПРИМЕНИТЬ',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
