import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/text/bloc/settings_bloc.dart';

class HtmlText extends StatelessWidget {
  final String text;

  const HtmlText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = BlocProvider.of<ThemeBloc>(context).state;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return HtmlWidget(
          text,
          enableCaching: false,
          customStylesBuilder: (element) {
            final styles = <String>[];

            if (element.localName == 'blockquote')
              styles.addAll(['margin', '0', 'padding', '10px 15px']);

            if (element.localName == 'blockquote' &&
                element.className == 'blue')
              styles.addAll(
                ['background-color', themeState.aayahBlockquoteBlueBg],
              );

            if (element.localName == 'blockquote' &&
                element.className == 'green')
              styles.addAll(
                ['background-color', themeState.aayahBlockquoteGreenBg],
              );

            if (element.localName == 'ul' || element.localName == 'ol')
              styles.addAll(['margin-left', '16px', 'padding', '0']);

            if (element.className == 'snoski')
              styles.addAll([
                'padding',
                '10px',
                'background-color',
                themeState.aayahFootnoteBg,
              ]);

            if (element.className == 'specdiv')
              styles.addAll([
                'padding',
                '10px',
                'background-color',
                themeState.aayahSpecDivBg,
              ]);

            return styles;
          },
          textStyle: TextStyle(
            fontSize: state.fontSize,
            height: 1.6,
            color: themeState.htmlTextColor,
          ),
          hyperlinkColor: Theme.of(context).primaryColor,
          onTapUrl: (url) => _goto(context, url),
        );
      },
    );
  }

  void _goto(BuildContext context, String url) async {
    final prefix = 'https://azan.ru/tafsir/';

    if (url.startsWith(prefix)) {
      final suffix = url.replaceAll(prefix, '');

      final regExp = RegExp(r'^([^/]+)(?:/\d+-\d+/(\d+))?$');
      final firstMatch = regExp.firstMatch(suffix);

      if (firstMatch != null) {
        final repository = RepositoryProvider.of<TafsirRepository>(context);
        final surah = await repository.getSurahBySlug(firstMatch[1]);

        if (surah == null) {
          _badLinkNotification(context);
        } else {
          final aayah = int.parse(firstMatch[2]);
          BlocProvider.of<ActivePageBloc>(context)
              .add(ActivePageTextShown(surah, aayah));
        }
      } else {
        _badLinkNotification(context);
      }
    }
  }

  void _badLinkNotification(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Битая ссылка. Пожалуйста, попробуйте Перезагрузить данную суру через меню в верхнем правом углу. Если это непоможет, то оставьте отзыв об этом в Play Маркете.',
        ),
      ),
    );
  }
}
