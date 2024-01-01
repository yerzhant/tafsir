import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class MoreTextTool extends StatelessWidget {
  final Function() onFontFamilyPressed;

  const MoreTextTool(this.onFontFamilyPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, theme) {
        return Column(
          children: [
            _arabicFont(context, theme),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: _Buttons(theme),
            ),
            const Divider(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Коментарии',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  bloc: Modular.get(),
                  builder: (context, state) {
                    return Switch(
                      activeColor: primaryColor,
                      value: state.showFootnotes,
                      onChanged: (value) {
                        Modular.get<SettingsBloc>().add(
                          const SettingsEvent.toggleShowFootnotes(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  InkWell _arabicFont(BuildContext context, ThemeState theme) {
    return InkWell(
      onTap: onFontFamilyPressed,
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Text(
              'Шрифт',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Spacer(),
            BlocBuilder<SettingsBloc, SettingsState>(
              bloc: Modular.get(),
              builder: (context, state) {
                return Text(
                  state.aayahFontFamily,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: theme.listItemSubtitle,
                      ),
                );
              },
            ),
            const SizedBox(width: 40),
            SvgPicture.asset(
              'assets/icons/shevron-right.svg',
              color: theme.listItemSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final ThemeState theme;

  const _Buttons(
    this.theme, {
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
        _buttons(),
      ],
    );
  }

  Widget _buttons() {
    final settings = Modular.get<SettingsBloc>();

    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settings,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Button(
              'العربية',
              isActive: state.showAayaat,
              color: theme.listItemSubtitle,
              onTap: () {
                settings.add(const SettingsEvent.toggleShowAayaat());
              },
            ),
            const SizedBox(width: 10),
            _Button(
              'Перевод',
              isActive: state.showTranslation,
              color: theme.listItemSubtitle,
              onTap: () {
                settings.add(const SettingsEvent.toggleShowTranslation());
              },
            ),
            const SizedBox(width: 10),
            _Button(
              'Тафсир',
              isActive: state.showTafsir,
              color: theme.listItemSubtitle,
              onTap: () {
                settings.add(const SettingsEvent.toggleShowTafsir());
              },
            ),
          ],
        );
      },
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
