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
      child: Column(
        children: [
          _arabicFont(context),
          BlocBuilder<ThemeCubit, ThemeState>(
            bloc: Modular.get(),
            builder: (context, state) {
              return Divider(
                height: 1,
                color: state.listItemDivider,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: _Buttons(),
          ),
        ],
      ),
    );
  }

  InkWell _arabicFont(BuildContext context) {
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
              style: Theme.of(context).textTheme.headline6,
            ),
            const Spacer(),
            Text(
              'Scheherazade',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(width: 40),
            SvgPicture.asset('assets/icons/shevron-right.svg'),
          ],
        ),
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
          'Показать',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Button(
              'العربية',
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Перевод',
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Тафсир',
              isActive: true,
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Сноски',
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
  final GestureTapCallback onTap;

  const _Button(
    this.text, {
    Key? key,
    this.isActive = false,
    required this.onTap,
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
            border: !isActive ? Border.all(color: greyColor) : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: isActive ? Colors.white : greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
