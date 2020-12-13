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
      icon: const Icon(Icons.settings, size: iconSize),
      onPressed: () async {
        final settingsState = BlocProvider.of<SettingsBloc>(context).state;
        final settings = await showDialog<SettingsState>(
          context: context,
          child: _Dialog(
            aayahFontSize: settingsState.aayahFontSize,
            fontSize: settingsState.fontSize,
            showTranslation: settingsState.showTranslation,
            showTafsir: settingsState.showTafsir,
            isDisplayAlwaysOn: settingsState.isDisplayAlwaysOn,
            themeState: BlocProvider.of<ThemeBloc>(context).state,
          ),
        );

        if (settings != null) {
          BlocProvider.of<SettingsBloc>(context).add(
            SettingsChanged(
              settings.aayahFontSize,
              settings.fontSize,
              showTranslation: settings.showTranslation,
              showTafsir: settings.showTafsir,
              isDisplayAlwaysOn: settings.isDisplayAlwaysOn,
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
  final bool isDisplayAlwaysOn;
  final ThemeState themeState;

  const _Dialog({
    Key key,
    this.aayahFontSize,
    this.fontSize,
    this.showTranslation,
    this.showTafsir,
    this.isDisplayAlwaysOn,
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
  bool _isDisplayAlwaysOn;

  @override
  void initState() {
    super.initState();
    _aayahFontSize = widget.aayahFontSize;
    _fontSize = widget.fontSize;
    _showTranslation = widget.showTranslation;
    _showTafsir = widget.showTafsir;
    _isDisplayAlwaysOn = widget.isDisplayAlwaysOn;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки'),
      content: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 10),
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
              title: const Text('Перевод'),
              value: _showTranslation,
              onChanged: (value) {
                setState(() {
                  _showTranslation = value;
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Тафсир'),
              value: _showTafsir,
              onChanged: (value) {
                setState(() {
                  _showTafsir = value;
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Не выключать экран'),
              value: _isDisplayAlwaysOn,
              onChanged: (value) {
                setState(() {
                  _isDisplayAlwaysOn = value;
                });
              },
            ),
          ],
        ),
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
                showTranslation: _showTranslation,
                showTafsir: _showTafsir,
                isDisplayAlwaysOn: _isDisplayAlwaysOn,
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
