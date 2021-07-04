import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class HtmlTextWidget extends StatelessWidget {
  final String html;
  final double fontSize;
  final bool isRightAligned;
  final bool hasFootnotes;

  const HtmlTextWidget(
    this.html, {
    Key? key,
    required this.fontSize,
    this.isRightAligned = true,
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
      html,
      enableCaching: false,
      textStyle: TextStyle(
        fontSize: fontSize,
        color: theme.text,
        height: 1.5,
      ),
      hyperlinkColor: Theme.of(context).primaryColor,
      customStylesBuilder: (e) {
        final styles = <String, String>{};

        if (isRightAligned) {
          styles.addAll({'text-align': 'right'});
        }

        if (e.localName == 'blockquote') {
          styles.addAll({
            'margin': '0',
            'padding': '10px',
            'border': '1px solid #ebebee',
            'border-left': '2px solid #0088c7',
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
