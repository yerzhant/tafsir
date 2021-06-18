import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class MoreTextTool extends StatelessWidget {
  const MoreTextTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Column(
            children: [
              _arabicFont(context, state),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: _Buttons(state),
              ),
            ],
          );
        },
      ),
    );
  }

  InkWell _arabicFont(BuildContext context, ThemeState state) {
    return InkWell(
      onTap: () {
        theFeatureIsPlanned.asSnackBar(context);
      },
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Text(
              'Шрифт',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Spacer(),
            Text(
              'Scheherazade',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: state.listItemSubtitle,
                  ),
            ),
            const SizedBox(width: 40),
            SvgPicture.asset(
              'assets/icons/shevron-right.svg',
              color: state.listItemSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final ThemeState state;

  const _Buttons(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Показать',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Button(
              'العربية',
              color: state.listItemSubtitle,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Перевод',
              color: state.listItemSubtitle,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Тафсир',
              isActive: true,
              color: state.listItemSubtitle,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Сноски',
              color: state.listItemSubtitle,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final bool isActive;
  final Color color;
  final GestureTapCallback onTap;

  const _Button(
    this.text, {
    Key? key,
    required this.color,
    required this.onTap,
    this.isActive = false,
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
            color: isActive ? Theme.of(context).primaryColor : null,
            border: !isActive ? Border.all(color: color) : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: isActive ? Colors.white : color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
