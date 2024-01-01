import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class CancelGoToAayah extends StatelessWidget {
  final int number;
  final Function() onPressed;

  const CancelGoToAayah(this.number, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, state) {
        return Positioned(
          bottom: 221,
          right: 8,
          left: 8,
          height: 50,
          child: Container(
            padding: const EdgeInsets.only(right: 33, left: 10),
            decoration: BoxDecoration(
              color: state.cancelGoToAayahBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _text(context, state),
                const Spacer(),
                _button(),
              ],
            ),
          ),
        );
      },
    );
  }

  Text _text(BuildContext context, ThemeState state) {
    return Text(
      'Вы перешли на $number аят',
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color: state.cancelGoToAayahForeground,
          ),
    );
  }

  TextButton _button() {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Отмена',
        style: TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w900,
          decorationColor: primaryColor,
        ),
      ),
    );
  }
}
