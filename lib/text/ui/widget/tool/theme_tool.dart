import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class ThemeTool extends StatelessWidget {
  const ThemeTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: _Buttons(),
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Не выключать экран',
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Тема',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 12),
        BlocBuilder<ThemeCubit, ThemeState>(
          bloc: Modular.get(),
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Button(
                  'Светлая',
                  isActive: Theme.of(context).brightness == Brightness.light,
                  textColor: state.lightThemeButtonText,
                  onTap: () {
                    Modular.get<ThemeCubit>().light();
                  },
                ),
                const SizedBox(width: 10),
                _Button(
                  'Тёмная',
                  isBlack: true,
                  isActive: Theme.of(context).brightness == Brightness.dark,
                  textColor: state.dartThemeButtonText,
                  onTap: () {
                    Modular.get<ThemeCubit>().dark();
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isBlack;
  final Color textColor;
  final GestureTapCallback onTap;

  const _Button(
    this.text, {
    Key? key,
    required this.textColor,
    required this.onTap,
    this.isActive = false,
    this.isBlack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isBlack ? const Color(0xff12222c) : Colors.white,
            border: isActive
                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
