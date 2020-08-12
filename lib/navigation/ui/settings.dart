import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
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
            fontSize: BlocProvider.of<SettingsBloc>(context).state.fontSize,
            themeState: BlocProvider.of<ThemeBloc>(context).state,
          ),
        );

        if (settings != null) {
          BlocProvider.of<SettingsBloc>(context)
              .add(SettingsFontSizeChanged(settings.fontSize));

          BlocProvider.of<ActivePageBloc>(context).add(
            ActivePageTextShown(
              BlocProvider.of<ActivePageBloc>(context).state.surah,
              null,
            ),
          );
        }
      },
    );
  }
}

class _Dialog extends StatefulWidget {
  final double fontSize;
  final ThemeState themeState;

  const _Dialog({
    Key key,
    this.fontSize,
    this.themeState,
  }) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context, SettingsState(_fontSize));
          },
          child: Text(
            'OK',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Отмена',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
