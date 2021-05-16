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
      icon: const Icon(Icons.filter_1, size: iconSize),
      onPressed: () async {
        final aayah = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Перейти к аяту'),
            content: TextField(
              // autofocus: true,
              maxLength: 3,
              controller: _scrollToAayahController,
              decoration:
                  const InputDecoration(labelText: 'Введите номер аята'),
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ОТМЕНА',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    _scrollToAayahController.value.text,
                  );
                },
                child: Text(
                  'ПЕРЕЙТИ',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        );
        if (aayah != null && aayah.isNotEmpty) {
          BlocProvider.of<ActivePageBloc>(context).add(
            ActivePageTextScrolledTo(
              widget.activePageText.surah,
              BlocProvider.of<ActivePageBloc>(context).state.textHistory,
              widget.activePageText.bookmarks,
              int.parse(aayah),
            ),
          );
        }
      },
    );
  }
}
