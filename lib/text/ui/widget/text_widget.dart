import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

import 'html_text_widget.dart';

class TextWidget extends StatelessWidget {
  final Surah surah;
  final TextItem textItem;
  final void Function(TextWidget) toggleMenu;

  const TextWidget({
    Key? key,
    required this.surah,
    required this.textItem,
    required this.toggleMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleMenu(this),
      behavior: HitTestBehavior.translucent,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ..._divider(context),
              if (state.showAayaat) ..._aayah(context, state),
              if (state.showTranslation) ..._translation(state),
              if (textItem.tafsir.isNotEmpty && state.showTafsir)
                ..._tafsir(state),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _aayah(BuildContext context, SettingsState state) => [
        const SizedBox(height: 7),
        Text(
          textItem.textOrigin.trim(),
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: state.aayahFontFamily,
            fontSize: state.aayahFontSize,
            color: Theme.of(context).primaryColor,
            height: _getAayahLineHeight(state),
          ),
        )
      ];

  List<Widget> _divider(BuildContext context) => [
        const SizedBox(height: 7),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: greyColor.withOpacity(.3)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  textItem.title,
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Divider(
                height: 1,
                thickness: 1,
                color: greyColor.withOpacity(.3),
              ),
            ),
          ],
        )
      ];

  List<Widget> _translation(SettingsState state) => [
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            bloc: Modular.get(),
            builder: (context, theme) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: theme.translationBackground,
                child: HtmlTextWidget(
                  textItem.text,
                  fontSize: state.textFontSize,
                ),
              );
            },
          ),
        )
      ];

  List<Widget> _tafsir(SettingsState state) => [
        const SizedBox(height: 7),
        HtmlTextWidget(
          textItem.tafsir,
          fontSize: state.tafsirFontSize,
          hasFootnotes: true,
        ),
      ];

  void share() {
    final subject = '${surah.title}, ${textItem.weight} аят.';

    var text = '$subject\n\n';
    text += '${textItem.textOrigin}\n\n';
    text += textItem.text.parseHtml();

    if (textItem.tafsir.isNotEmpty) {
      text += '\n\n';
      text += textItem.tafsir.parseHtml();
    }

    Share.share(text, subject: subject);
  }

  double _getAayahLineHeight(SettingsState state) {
    switch (state.aayahFontFamily) {
      case 'Me Quran':
        return 1.9;

      case 'Scheherazade':
        return 1.3;

      default:
        return 1.5;
    }
  }
}
