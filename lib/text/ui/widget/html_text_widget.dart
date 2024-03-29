import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class HtmlTextWidget extends StatelessWidget {
  final String html;
  final double fontSize;
  final bool hasFootnotes;

  const HtmlTextWidget(
    this.html, {
    Key? key,
    required this.fontSize,
    this.hasFootnotes = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, theme) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          bloc: Modular.get(),
          builder: (context, state) {
            return _html(theme, state, context);
          },
        );
      },
    );
  }

  HtmlWidget _html(
    ThemeState theme,
    SettingsState state,
    BuildContext context,
  ) {
    return HtmlWidget(
      '<div class="html-content">$html</dev>',
      enableCaching: false,
      textStyle: TextStyle(
        fontSize: fontSize,
        color: theme.text,
        height: 1.5,
      ),
      customStylesBuilder: (e) {
        final styles = <String, String>{};

        if (e.className == 'html-content') {
          styles.addAll({'text-align': 'justify'});
        }

        styles.addAll({
          'margin': '0',
          'padding': '0',
        });

        if (e.localName == 'blockquote') {
          styles.addAll({
            'padding': '10px',
            'border': '1px solid rgba(189, 189, 194, .2)',
            'border-left': '2px solid #0088c7',
          });
        }

        if (e.localName == 'li') {
          styles.addAll({
            'padding-left': '20px',
          });
        }

        if (e.className == 'snoski') {
          styles.addAll({'color': '#0088c7'});

          if (hasFootnotes && !state.showFootnotes) {
            styles.addAll({'display': 'none'});
          }
        }

        return styles;
      },
    );
  }
}
