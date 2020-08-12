import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';

class GoToAayah extends StatefulWidget {
  final ActivePageText activePageText;

  const GoToAayah({Key key, this.activePageText}) : super(key: key);

  @override
  _GoToAayahState createState() => _GoToAayahState();
}

class _GoToAayahState extends State<GoToAayah> {
  final _scrollToAayahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Перейти к аяту',
      icon: Icon(Icons.filter_1, size: iconSize),
      onPressed: () async {
        final String aayah = await showDialog(
          context: context,
          child: AlertDialog(
            content: TextField(
              autofocus: true,
              maxLength: 3,
              controller: _scrollToAayahController,
              decoration: InputDecoration(labelText: 'Перейти к аяту'),
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    _scrollToAayahController.value.text,
                  );
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
          ),
        );
        if (aayah != null && aayah.isNotEmpty)
          BlocProvider.of<ActivePageBloc>(context).add(
            ActivePageTextScrolledTo(
              widget.activePageText.surah,
              widget.activePageText.bookmarks,
              int.parse(aayah),
            ),
          );
      },
    );
  }
}
