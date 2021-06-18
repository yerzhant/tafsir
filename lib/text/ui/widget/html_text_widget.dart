import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class HtmlTextWidget extends StatelessWidget {
  final String html;
  final bool isRightAligned;

  const HtmlTextWidget(
    this.html, {
    Key? key,
    this.isRightAligned = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, state) {
        return HtmlWidget(
          html,
          textStyle: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: state.text,
          ),
          hyperlinkColor: Theme.of(context).primaryColor,
          customStylesBuilder: (e) {
            final styles = <String, String>{};

            if (isRightAligned) {
              styles.addAll({'text-align': 'right'});
            }

            if (e.localName == 'blockquote') {
              styles.addAll({
                'padding': '10px',
                'border': '1px solid #ebebee',
                'border-left': '2px solid #0088c7',
              });
            }

            if (e.className == 'snoski') {
              styles.addAll({'color': '#0088c7'});
            }

            return styles;
          },
        );
      },
    );
  }
}
