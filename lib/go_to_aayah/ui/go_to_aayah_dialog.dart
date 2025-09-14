import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/go_to_aayah/bloc/go_to_aayah_bloc.dart';

class GoToAayahDialog extends StatefulWidget {
  const GoToAayahDialog({Key? key}) : super(key: key);

  @override
  _GoToAayahDialogState createState() => _GoToAayahDialogState();
}

class _GoToAayahDialogState extends State<GoToAayahDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _dialog(context),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 22, left: 14),
            child: Icon(Icons.open_in_new, color: primaryColor, size: 22),
          ),
          Text(
            'Перейти к аяту',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Future<void> _dialog(BuildContext context) async {
    final aayah = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ПЕРЕЙТИ К АЯТУ'),
        content: TextField(
          maxLength: 3,
          controller: _controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ОТМЕНА'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                _controller.value.text,
              );
            },
            child: const Text('ПЕРЕЙТИ'),
          ),
        ],
      ),
    );
    if (aayah != null && aayah.isNotEmpty) {
      Modular.get<GoToAayahBloc>().add(GoToAayahEvent.goto(int.parse(aayah)));
      _controller.clear();
    }
  }
}
