import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class TextContextMenu extends StatelessWidget {
  final Surah surah;
  final TextItem textItem;

  const TextContextMenu(
    this.surah,
    this.textItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Container(
            color: state.toolsBackground,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: Column(
              children: [
                Text(
                  '${surah.title}: ${textItem.title} аят',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24, left: 16),
                      child: SvgPicture.asset('assets/icons/play.svg'),
                    ),
                    Text(
                      'Воспроизвести',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const Divider(height: 27),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24, left: 16),
                      child: SvgPicture.asset('assets/icons/bookmark.svg'),
                    ),
                    Text(
                      'В закладки',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const Divider(height: 27),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24, left: 16),
                      child: SvgPicture.asset('assets/icons/share.svg'),
                    ),
                    Text(
                      'Поделиться',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
