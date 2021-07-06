import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class ChooseAayaatFont extends StatelessWidget {
  final ThemeState theme;
  final Function() onBackPressed;

  const ChooseAayaatFont(this.theme, this.onBackPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: Modular.get(),
      builder: (context, settings) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: GestureDetector(
                onTap: onBackPressed,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/arrow-left.svg'),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            _Font('KFGQPC Uthman Taha Naskh', theme, settings),
            const Divider(height: 1),
            _Font('Scheherazade', theme, settings),
            const Divider(height: 1),
            _Font('Me Quran', theme, settings),
            const Divider(height: 1),
            _Font('Noorehira', theme, settings),
            const Divider(height: 1),
            _Font('PDMS Saleem', theme, settings),
            const Divider(height: 1),
            _Font('Sheikh Hamdullah', theme, settings),
          ],
        );
      },
    );
  }
}

class _Font extends StatelessWidget {
  final String family;
  final ThemeState theme;
  final SettingsState settings;

  const _Font(this.family, this.theme, this.settings, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = settings.aayahFontFamily == family;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Modular.get<SettingsBloc>()
          .add(SettingsEvent.setAayahFontFamily(family)),
      child: SizedBox(
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  family,
                  style: TextStyle(
                    color: isSelected ? primaryColor : theme.text,
                    fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
                  style: TextStyle(
                    fontFamily: family,
                    color: greyColor,
                    fontSize: 19,
                    height: 1,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 3.75),
                child: SvgPicture.asset('assets/icons/checked.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
